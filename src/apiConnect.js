/**
 * Menu for database
 *
 * @author Adam
 */
"use strict";

const { createAuth0Client } = require('auth0');
const jwt = require('express-jwt');

class apiConnect {
    /**
     * @constructor
     */
    constructor() {
        this.auth0Client = null;
    }

    async fetchAuthConfig() {
        return fetch("./auth_config.json");
    }

    async configureClient() {
    //   const response = await this.fetchAuthConfig();
    //   const config = await response.json();

      this.auth0Client = await auth.createAuth0Client({
        domain: "ticket-client.eu.auth0.com",
        clientId: "pLSRxBeVrm15LKVNyL01zeckD3w28uhi",
        authorizationParams: {
          audience: "http://ticket-client/api"   // NEW - add the audience value
        }
      });
    };

    getUser = async () => {
        await this.configureClient();

        const isAuthenticated = await auth0Client.isAuthenticated();

        // NEW - add logic to show/hide gated content after authentication
        if (isAuthenticated) {
            const user = await auth0Client.getUser();

            console.info("email");
            console.info(user.email);

            return user.email;
        } else {
          console.info("Not authenticated");
        }
    };
}

module.exports = apiConnect;