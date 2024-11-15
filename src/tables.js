/**
 * Menu for database
 *
 * @author Adam
 */
"use strict";

class tables {
    /**
     * @constructor
     */
    constructor() {
    }

    /**
     * Get from database.
     *
     * @param {database} db the relevant database
     * @param {string} table what to select
     * @param {int} num number to get.
     *
     * @returns {array<sql>}
     *
     */
    async getFromDB(db, table, num, chr="") {
        let sql;
        let rows;

        sql = `
        CALL select_from_db(?, ?, ?);
        `;

        rows = await db.query(sql, [table, parseInt(num), chr]);

        return rows[0];
    }

    /**
     * Get from database.
     *
     * @param {database} db the relevant database
     * @param {string} user the user who is creating.
     * @param {string} title title of ticket.
     * @param {string} desc description of problem.
     * @param {string} category problems category.
     * @param {bin} file problems category.
     *
     * @returns void
     *
     */
    async createTicket(db, user, title, desc, category, file, fileName) {
        let sql;
        let rows;

        sql = `
        CALL createTicket(?, ?, ?, ?, ?, ?);
        `;

        rows = await db.query(sql, [user, title, desc, category, file, fileName]);
    }

    /**
     * Get from database.
     *
     * @param {database} db the relevant database
     * @param {string} user the user who is creating.
     * @param {string} title title of ticket.
     * @param {string} text description of problem.
     * @param {string} category problems category.
     *
     * @returns void
     *
     */
    async createArticle(db, user, title, text, category) {
        let sql;
        let rows;

        sql = `
        CALL createArticle(?, ?, ?, ?);
        `;

        rows = await db.query(sql, [user, title, text, category]);
    }

    /**
     * Get from database.
     *
     * @param {database} db the relevant database
     * @param {string} id ticket id.
     * @param {string} status new status.
     *
     * @returns void
     *
     */
    async changeTicket(db, id, status) {
        let sql;
        let rows;

        sql = `
        CALL changeTicket(?, ?);
        `;

        rows = await db.query(sql, [id, status]);
    }

    /**
     * Get from database.
     *
     * @param {database} db the relevant database
     * @param {string} email user email.
     * @param {string} role user role.
     *
     * @returns void
     *
     */
    async changeRole(db, email, role) {
        let sql;
        let rows;

        sql = `
        CALL changeRole(?, ?);
        `;

        rows = await db.query(sql, [email, role]);
    }

    /**
     * Claims ticket.
     *
     * @param {database} db the relevant database
     * @param {int} id ticket id.
     * @param {string} email user email.
     *
     * @returns void
     *
     */
    async claimTicket(db, id, email) {
        let sql;
        let rows;

        sql = `
        CALL claimTicket(?, ?);
        `;

        rows = await db.query(sql, [id, email]);
    }

    /**
     * Unclaims ticket.
     *
     * @param {database} db the relevant database
     * @param {int} id ticket id.
     *
     * @returns void
     *
     */
    async unclaimTicket(db, id) {
        let sql;
        let rows;

        sql = `
        CALL unclaimTicket(?);
        `;

        rows = await db.query(sql, [id]);
    }

    /**
     * Makes comment on ticket.
     *
     * @param {database} db the relevant database
     * @param {string} ticket_id ticket id.
     * @param {string} user_id user id.
     * @param {string} title comment-title.
     * @param {string} comment the comment.
     *
     * @returns void
     *
     */
    async makeComment(db, ticket_id, user_id, title, comment) {
        let sql;
        let rows;

        sql = `
        CALL makeComment(?, ?, ?, ?);
        `;

        rows = await db.query(sql, [ticket_id, user_id, title, comment]);
    }

    /**
     * Creates new category.
     *
     * @param {database} db the relevant database
     * @param {string} name category name.
     *
     * @returns void
     *
     */
    async createCategory(db, name) {
        let sql;
        let rows;

        sql = `
        CALL createCategory(?);
        `;

        rows = await db.query(sql, [name]);
    }

    /**
     * Creates new user if nedded.
     *
     * @param {database} db the relevant database
     * @param {string} email user email.
     *
     * @returns void
     *
     */
    async createUser(db, email) {
        let sql;
        let rows;

        sql = `
        CALL select_from_db(?, ?, ?);
        `;

        rows = await db.query(sql, ["all-users", 0, ""]);

        sql = `
        CALL make_user(?)
        `;

        if (email == "") {
            return;
        }

        for (let i = 0; i < rows[0].length; i++) {
            if (rows[0][i].email == email) {
                return;
            }
        }
        await db.query(sql, [email]);
    }

    /**
     * Updates session.
     *
     * @param {database} db the relevant database
     * @param {string} email users email.
     *
     * @returns void
     *
     */
    async updateSession(db, email) {
        let sql;

        sql = `
        CALL update_session(?);
        `;

        await db.query(sql, [email]);
    }
}

module.exports = tables;
