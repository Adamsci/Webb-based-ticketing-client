/**
 * General routes.
 */
"use strict";

var express = require('express');
var router  = express.Router();
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const tables = require("../src/tables");
const tb = new tables();
const mysql = require("promise-mysql");
const multer = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });
//const { updateUserJSON } = require('../public/js/app');
//import { updateUserJSON } from '../public/js/app.js';

const config = require("../config/db/tickets.json");

// Add a route for the path /
router.get('/', async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    res.render("tickets/index", data);
});

router.post("/", urlencodedParser, async (req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));
    let data = {};
    let db;

    db = await mysql.createConnection(config);

    data.res = await tb.updateSession(db, req.body.userinput);

    await tb.createUser(db, req.body.userinput);

    res.redirect(`./`);
});

router.get("/about", async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    res.render("tickets/about", data);
});

router.get("/ticket-create/", async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    data.res = await tb.getFromDB(db, 'categories', 0);

    res.render("tickets/ticket-create", data);
});

router.post("/ticket-create/", upload.single('file'), urlencodedParser, async (req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));
    let data = {};
    let db;

    db = await mysql.createConnection(config);

    let fileBuffer = req.file ? req.file.buffer : null;
    let fileName = req.file ? req.file.originalname : null; // Get original file name

    data.res = await tb.getFromDB(db, 'users', 0, req.body.userinput);

    await tb.createTicket(db, data.res[0].id, req.body.title, req.body.desc, req.body.category, fileBuffer, fileName);

    res.redirect(`../tickets`);
});

router.get("/category-create/", async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    res.render("tickets/category-create", data);
});

router.post("/category-create/", urlencodedParser, async (req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));
    let data = {};
    let db;

    db = await mysql.createConnection(config);

    await tb.createCategory(db, req.body.category);

    res.redirect(`../tickets`);
});

router.get("/tickets", async (req, res) => {
    let db;
    let data = {};

    db = await mysql.createConnection(config);

    data.res = await tb.getFromDB(db, 'ticket-info', 0);
    data.res2 = await tb.getFromDB(db, 'ticket-info', 0);

    data.email = await tb.getFromDB(db, 'session', 0);

    res.render("tickets/tickets", data);
});

router.post("/tickets/", urlencodedParser, async (req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));
    let data = {};
    let db;

    db = await mysql.createConnection(config);

    data.res = await tb.updateSession(db, req.body.userinput);

    await tb.createUser(db, req.body.userinput);

    res.redirect(`./tickets`);
});

router.get("/ticket-view/:id", async (req, res) => {
    let id = req.params.id;
    let db;
    let data = {};

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    data.res = await tb.getFromDB(db, 'ticket-info-one', id);
    data.res2 = await tb.getFromDB(db, 'comments', id);
    data.session = await tb.getFromDB(db, 'session', 0, '');

    data.related = await tb.getFromDB(db, 'articles-category', 0, data.res[0].category);

    res.render("tickets/ticket-view-id", data);
});

router.post("/ticket-view/:id", urlencodedParser, async (req, res) => {
    let id = req.params.id;
    let db;
    let data = {};

    console.info("com");


    db = await mysql.createConnection(config);

    data.rest = await tb.getFromDB(db, 'ticket-info-one', id);

    data.session = await tb.getFromDB(db, 'session', 0, '');

    data.res = await tb.getFromDB(db, 'users', 0, req.body.userinput);

    if (req.body.s_status != null) {
        await tb.changeTicket(db, id, req.body.s_status);
    } else if (req.body.desc) {
        console.info(req.body.userinput);
        console.info(data);
        console.info(data.res);
        console.info(data.res[0]);
        console.info(data.res[0].id);
        await tb.makeComment(db, id, data.res[0].id, req.body.title, req.body.desc);
    }

    if (data.rest[0].agent_email == null && data.session[0].is_agent == 1) {
        await tb.claimTicket(db, id, req.body.agentinput);
    } else if (data.rest[0].agent_email != null && req.body.desc == "" && (data.session[0].role == 'admin' ||
            data.session[0].user_email == data.rest[0].agent_email)) {
        await tb.unclaimTicket(db, id);
    }

    res.redirect(`./` + id);
});

router.post("/ticket-view/:id/claim", urlencodedParser, async (req, res) => {
    let id = req.params.id;
    let db;
    let data = {};

    console.info("claim");

    db = await mysql.createConnection(config);

    data.rest = await tb.getFromDB(db, 'ticket-info-one', id);

    data.session = await tb.getFromDB(db, 'session', 0, '');

    data.res = await tb.getFromDB(db, 'users', 0, req.body.userinput);

    if (data.rest[0].agent_email == null && data.session[0].is_agent == 1) {
        await tb.claimTicket(db, id, req.body.agentinput);
    } else if (data.rest[0].agent_email != null && (data.session[0].role == 'admin' ||
            data.session[0].user_email == data.rest[0].agent_email)) {
        await tb.unclaimTicket(db, id);
    }

    res.redirect(`../` + id);
});

router.get('/download/:id', async (req, res) => {
    let ticketId = req.params.id;
    let db = await mysql.createConnection(config);

    // Query to fetch file data for the given ticket ID
    let results = await tb.getFromDB(db, 'ticket-info-one', ticketId);

    if (results.length > 0) {
        let fileData = results[0].file_data;
        let fileName = results[0].file_name || 'file';

        // Set appropriate headers for file download
        res.setHeader('Content-Disposition', 'attachment; filename=' + fileName);
        res.setHeader('Content-Type', 'application/octet-stream');

        // Send the BLOB data as the file content
        res.send(fileData);
    } else {
        res.status(404).send('File not found');
    }
});

router.get('/knowledge-base', async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    data.res = await tb.getFromDB(db, 'articles', 0);

    res.render("tickets/knowledge-base", data);
});

router.get("/article-view/:id", async (req, res) => {
    let id = req.params.id;
    let db;
    let data = {};

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    data.res = await tb.getFromDB(db, 'articles-one', id);

    data.related = await tb.getFromDB(db, 'articles-category', 0, data.res[0].category_name);

    res.render("tickets/article-view-id", data);
});

router.get("/article-create/", async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    data.res = await tb.getFromDB(db, 'categories', 0);

    res.render("tickets/article-create", data);
});

router.post("/article-create/", urlencodedParser, async (req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));
    let data = {};
    let db;

    db = await mysql.createConnection(config);

    data.res = await tb.getFromDB(db, 'users', 0, req.body.userinput);

    await tb.createArticle(db, data.res[0].id, req.body.title, req.body.articletext, req.body.category);

    res.redirect(`../knowledge-base`);
});

router.get("/config/", async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);
    data.email = await tb.getFromDB(db, 'session', 0);

    data.res = await tb.getFromDB(db, 'all-users', 0);

    res.render("tickets/config", data);
});

router.post("/config/", urlencodedParser, async (req, res) => {
    let db;
    let data = {};

    db = await mysql.createConnection(config);

    if (req.body.role != null) {
        await tb.changeRole(db, req.body.userinput, req.body.role);
    }

    res.redirect(`./config`);
});

module.exports = router;
