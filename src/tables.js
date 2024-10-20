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

    /**
     * Creates order.
     *
     * @param {database} db the relevant database
     * @param {int{int}} produkter produkt_id key for antal
     * @param {int} kundId id for kund
     *
     * @returns void
     *
     */
    async createOrder(db, produkter, kundId) {
        let sql;

        sql = `
        CALL create_order(?);
        `;

        let orderId = await db.query(sql, [parseInt(kundId)]);

        sql = `
        CALL order_produkt(?, ?, ?);
        `;

        for (let produktId in produkter) {
            produkter[produktId];

            if (produkter[produktId] != 0) {
                if (produktId < 14) {
                    await db.query(sql, [parseInt(orderId[0][0].id),
                        parseInt(produktId)+1, parseInt(produkter[produktId])]);
                } else {
                    await db.query(sql, [parseInt(orderId[0][0].id),
                        parseInt(produktId)+2, parseInt(produkter[produktId])]);
                }
            }
        }

        // for (let produkt_id in produkter) {
        //     antal = products[produkt_id];
        //     await db.query(sql, [order_id, parseInt(produkt_id), parseInt(antal)]);
        // }
    }

    /**
     * Creates or updates kund.
     *
     * @param {database} db the relevant database
     * @param {string} namn namn of kund
     * @param {string} address address of kund
     * @param {string} telefon phone-number of kund
     *
     * @returns int
     *
     */
    async createKund(db, namn, address, telefon) {
        let sql;

        sql = `
        CALL create_kund(?, ?, ?);
        `;

        return await db.query(sql, [namn, address, telefon]);
    }

    /**
     * Deletes produkt.
     *
     * @param {database} db the relevant database
     * @param {int} id id for the product
     *
     * @returns void
     *
     */
    async deleteProdukt(db, id) {
        let sql;

        sql = `
        CALL delete_produkt(?);
        `;

        await db.query(sql, [parseInt(id)]);
    }

    /**
     * Edits produkt.
     *
     * @param {database} db the relevant database
     * @param {int} id id for the product
     * @param {string} name name of the product
     * @param {int} pris price for the product
     *
     * @returns void
     *
     */
    async editProdukt(db, id, name, pris) {
        let sql;

        sql = `
        CALL edit_produkt(?, ?, ?);
        `;

        await db.query(sql, [parseInt(id), name, parseInt(pris)]);
    }

    /**
     * Edits produkt.
     *
     * @param {database} db the relevant database
     * @param {string} name name of the product
     * @param {int} pris price for the product
     *
     * @returns void
     *
     */
    async createProdukt(db, name, pris) {
        let sql;

        sql = `
        CALL create_produkt(?, ?);
        `;

        await db.query(sql, [name, parseInt(pris)]);
    }

    /**
     * Shows table with logs.
     *
     * @param {database} database the relevant database
     * @param {int} number the last log
     *
     * @returns void
     *
     */
    async showLog(db, number) {
        let rows;
        let str;

        rows = await this.getFromDB(db, 'log', number);

        str  = "\n+----+--------------------------+-------------------+------------+\n";
        str += "| id | when                     | handelse          | produkt_id |\n";
        str += "+----+--------------------------+-------------------+------------+\n";
        for (let i = 0; i < rows.length; i++) {
            str += "| ";
            str += rows[i].id.toString().padEnd(3);
            str += "| ";
            str += rows[i].when.toISOString().padEnd(25);
            str += "| ";
            str += rows[i].handelse.padEnd(18);
            str += "|";
            str += rows[i].produkt_id.toString().padStart(11);
            str += " |\n";
        }
        str += "+----+--------------------------+-------------------+------------+\n";

        console.info(str);
    }

    /**
     * Shows table with logs.
     *
     * @param {database} database the relevant database
     * @param {int} number the last log
     *
     * @returns void
     *
     */
    async showProduct(db) {
        let rows;
        let str;

        rows = await this.getFromDB(db, 'product', 0);

        str = "\n+----+------------------------------------+------+";
        str += "------------------------+--------------------------------------+\n";
        str += "| id | name                               | pris | farg";
        str += "                   | material                             |\n";
        str += "+----+------------------------------------+------+------";
        str += "------------------+--------------------------------------+\n";
        for (let i = 0; i < rows.length; i++) {
            str += "| ";
            str += rows[i].id.toString().padEnd(3);
            str += "| ";
            str += rows[i].name.padEnd(35);
            str += "| ";
            str += rows[i].pris.toString().padEnd(5);
            str += "| ";
            str += rows[i].farg.padEnd(23);
            str += "| ";
            str += rows[i].material.padEnd(36);
            str += " |\n";
        }
        str += "+----+------------------------------------+------+";
        str += "------------------------+--------------------------------------+\n";

        console.info(str);
    }

    /**
     * Shows table with logs.
     *
     * @param {database} database the relevant database
     * @param {int} number the last log
     *
     * @returns void
     *
     */
    async showShelves(db) {
        let rows;
        let str;

        rows = await this.getFromDB(db, 'shelf', 0);

        str  = "\n+-------+-------+\n";
        str += "| hylla | antal |\n";
        str += "+-------+-------+\n";
        for (let i = 0; i < rows.length; i++) {
            str += "| ";
            str += rows[i].hylla.toString().padEnd(6);
            str += "| ";
            str += rows[i].antal.toString().padEnd(5);
            str += " |\n";
        }
        str += "+-------+-------+\n";

        console.info(str);
    }

    /**
     * Shows table with inventory.
     *
     * @param {database} database the relevant database
     * @param {int} number the last log
     *
     * @returns void
     *
     */
    async showInventory(db, filter) {
        let rows;
        let str;

        rows = await this.getFromDB(db, 'inv', 0);

        str  = "\n+-------+-------+----+------------------------------------+\n";
        str += "| hylla | antal | id | name                               |\n";
        str += "+-------+-------+----+------------------------------------+\n";
        for (let i = 0; i < rows.length; i++) {
            if (filter == "" ||
                rows[i].hylla.toString() == filter ||
                rows[i].id.toString() == filter ||
                rows[i].name.includes(filter)) {
                str += "| ";
                str += rows[i].hylla.toString().padEnd(6);
                str += "| ";
                str += rows[i].antal.toString().padEnd(6);
                str += "| ";
                str += rows[i].id.toString().padEnd(3);
                str += "| ";
                str += rows[i].name.padEnd(34);
                str += " |\n";
            }
        }
        str += "+-------+-------+----+------------------------------------+\n";

        console.info(str);
    }

    /**
     * Adds product to inventory.
     *
     * @param {database} database the relevant database
     * @param {int} produktid the id
     * @param {int} shelf the shelf to add to
     * @param {int} number number to add
     *
     * @returns void
     *
     */
    async addProdukt(db, produktid, shelf, number) {
        let sql;

        sql = `
        CALL addProdukt(?, ?, ?);
        `;

        await db.query(sql, [parseInt(produktid), parseInt(shelf), parseInt(number)]);
    }

    /**
     * Removes product from inventory.
     *
     * @param {database} database the relevant database
     * @param {int} produktid the id
     * @param {int} shelf the shelf to add to
     * @param {int} number number to add
     *
     * @returns void
     *
     */
    async removeProdukt(db, produktid, shelf, number) {
        let sql;

        sql = `
        CALL removeProdukt(?, ?, ?);
        `;

        await db.query(sql, [parseInt(produktid), parseInt(shelf), parseInt(number)]);
    }

    /**
     * Shows table with orders.
     *
     * @param {database} database the relevant database
     * @param {string} filter id to search for
     *
     * @returns void
     *
     */
    async showOrder(db, filter) {
        let rows;
        let str;

        rows = await this.getFromDB(db, 'order1', 0);

        str  = "\n+----+---------+--------------------------+-------------+-------+-----------+\n";
        str += "| id | kund_id | skapad_datum             | totalbelopp | antal | status    |\n";
        str += "+----+---------+--------------------------+-------------+-------+-----------+\n";
        for (let i = 0; i < rows.length; i++) {
            if (filter == "" ||
                rows[i].id.toString() == filter ||
                rows[i].kund_id.toString() == filter) {
                str += "| ";
                str += rows[i].id.toString().padEnd(3);
                str += "| ";
                str += rows[i].kund_id.toString().padEnd(8);
                str += "| ";
                str += rows[i].skapad_datum.toISOString().padEnd(25);
                str += "| ";
                str += rows[i].totalbelopp.toString().padEnd(12);
                str += "| ";
                str += rows[i].antal.toString().padEnd(6);
                str += "| ";
                str += rows[i].status.padEnd(9);
                str += " |\n";
            }
        }
        str += "+----+---------+--------------------------+-------------+-------+-----------+\n";

        console.info(str);
    }

    /**
     * Creates picklist.
     *
     * @param {database} database the relevant database
     * @param {int} filter the orderid to search for
     *
     * @returns void
     *
     */
    async createPicklist(db, filter) {
        let rows;
        let str;

        rows = await this.getFromDB(db, 'picklist', parseInt(filter));

        str  = "\n+------------+------------------------------------+";
        str += "-------------+-------------+-------+----------+\n";
        str += "| produkt_id | name                               ";
        str += "| order_antal | lager_antal | hylla | I lager? |\n";
        str += "+------------+------------------------------------+";
        str += "-------------+-------------+-------+----------+\n";
        for (let i = 0; i < rows.length; i++) {
            str += "| ";
            str += rows[i].produkt_id.toString().padEnd(11);
            str += "| ";
            str += rows[i].name.padEnd(35);
            str += "| ";
            str += rows[i].order_antal.toString().padEnd(12);
            str += "| ";
            str += rows[i].lager_antal.toString().padEnd(12);
            str += "| ";
            str += rows[i].hylla.toString().padEnd(6);
            str += "| ";
            if (rows[i].order_antal <= rows[i].lager_antal) {
                str += "Ja      ";
            } else {
                str += "Nej     ";
            }
            str += " |\n";
        }
        str += "+------------+------------------------------------+";
        str += "-------------+-------------+-------+----------+\n";

        console.info(str);
    }
}

module.exports = tables;
