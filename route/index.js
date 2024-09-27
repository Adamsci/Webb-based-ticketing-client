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

const config = require("../config/db/tickets.json");

// Add a route for the path /
router.get('/', (req, res) => {
    res.redirect(`./tickets/index`);
});

router.get("/tickets/index", (req, res) => {
    let data = {};

    res.render("tickets/index", data);
});

router.get("/tickets/about", async (req, res) => {
    let data = {};

    res.render("tickets/about", data);
});

router.get("/tickets/tickets", async (req, res) => {
    let data = {};

    res.render("tickets/tickets", data);
});

router.get("/tickets/ticket-create/", async (req, res) => {
    let data = {};
    let db;

    db = await mysql.createConnection(config);

    data.res = await tb.getFromDB(db, 'categories', 0);

    res.render("tickets/ticket-create", data);
});

router.post("/tickets/ticket-create/", upload.single('file'), urlencodedParser, async (req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));
    let db;

    db = await mysql.createConnection(config);

    let fileBuffer = req.file ? req.file.buffer : null;
    let fileName = req.file ? req.file.originalname : null; // Get original file name

    await tb.createTicket(db, req.body.title, req.body.desc, req.body.category, fileBuffer, fileName);

    res.redirect(`../tickets/tickets`);
});

router.get("/tickets/ticket-view", async (req, res) => {
    let db;
    let data = {};

    db = await mysql.createConnection(config);

    data.res = await tb.getFromDB(db, 'ticket-info', 0);

    res.render("tickets/ticket-view", data);
});

router.get("/tickets/ticket-view/:id", async (req, res) => {
    let id = req.params.id;
    let db;
    let data = {};

    db = await mysql.createConnection(config);

    data.res = await tb.getFromDB(db, 'ticket-info-one', id);

    res.render("tickets/ticket-view-id", data);
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

module.exports = router;
