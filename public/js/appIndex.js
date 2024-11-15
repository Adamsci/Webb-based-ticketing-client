let auth0Clint = null;
let userEmail = null;

const fetchAuthConfig = () => fetch("/auth_config.json");

const configureClient = async () => {
  const response = await fetchAuthConfig();
  const config = await response.json();

  auth0Client = await auth0.createAuth0Client({
    domain: config.domain,
    clientId: config.clientId
  });
};

const callApi = async () => {
  try {

    // Get the access token from the Auth0 client
    const token = await auth0Client.getTokenSilently();

    // Make the call to the API, setting the token
    // in the Authorization header
    const response = await fetch("/api/external", {
      headers: {
        Authorization: `Bearer ${token}`
      }
    });

    // Fetch the JSON result
    const responseData = await response.json();

    // Display the result in the output element
    const responseElement = document.getElementById("api-call-result");

    responseElement.innerText = JSON.stringify(responseData, {}, 2);

  } catch (e) {
      // Display errors in the console
      console.error(e);
    }
};

window.onload = async () => {
    console.info("Onload");
    await configureClient();

    // NEW - update the UI state
    updateUI();

    const isAuthenticated = await auth0Client.isAuthenticated();

    if (isAuthenticated) {
        // show the gated content
        return;
    }

    // NEW - check for the code and state parameters
    const query = window.location.search;
    if (query.includes("code=") && query.includes("state=")) {

        // Process the login state
        await auth0Client.handleRedirectCallback();

        updateUI();

        // Use replaceState to redirect the user away and remove the querystring parameters
        window.history.replaceState({}, document.title, "/");
    }
};

// NEW
const updateUI = async () => {
    console.info("Update2");

    const isAuthenticated = await auth0Client.isAuthenticated();

    document.getElementById("btn-logout").disabled = !isAuthenticated;
    document.getElementById("btn-login").disabled = isAuthenticated;
    document.getElementById("btn-call-api").disabled = !isAuthenticated;

    if (isAuthenticated) {
      const user = await auth0Client.getUser();
      document.getElementById("gated-content").classList.remove("hidden");

      document.getElementById(
        "ipt-access-token"
      ).innerHTML = await auth0Client.getTokenSilently();

      document.getElementById("ipt-user-profile").textContent = JSON.stringify(
        await auth0Client.getUser()
      );
      document.getElementById("ipt-user-profile").textContent = JSON.stringify(
        await auth0Client.getUser()
      );
      document.getElementById("ipt-user-email").textContent = JSON.stringify(
        user.email
      );
      document.getElementById("userinput").value = user.email;
      userEmail = user.email;

      console.info(localStorage.getItem("needsReload"));
      if (await needsPost()) {
        localStorage.setItem("needsReload", "no");
        document.forms['usernameform'].submit();
      }

    } else {
      document.getElementById("gated-content").classList.add("hidden");
      if (await needsPost()) {
        localStorage.setItem("needsReload", "no");
        document.forms['usernameform'].submit();
      }
    }
};

const needsPost = async () => {
    console.info("needsPost")
    if (localStorage.getItem("needsReload") == null) {
    localStorage.setItem("needsReload", "yes");
    }
    if (localStorage.getItem("needsReload") == "yes") {
    return true;
    } else {
    return false;
    }
};

const updateUserJSON = async () => {
    try {
      const isAuthenticated = await auth0Client.isAuthenticated();

      if (isAuthenticated) {
        const user = await auth0Client.getUser();

        // Return the user JSON
        return JSON.stringify(
          user,
          Object.keys(user).filter(key =>
            !key.startsWith('_') && typeof user[key] !== 'function'
          ),
          2
        );
      } else {
        console.error("User is not authenticated");
        return null;
      }
    } catch (err) {
      console.error("Error fetching user data:", err);
      throw err;
    }
  };

const login = async () => {
    console.info("Login");
    await auth0Client.loginWithRedirect({
        authorizationParams: {
            redirect_uri: "http://localhost:3000"
        }
    });
    localStorage.setItem("logindex", "yes");
};

const logout = () => {
    console.info("Log out");
    auth0Client.logout({
        logoutParams: {
            returnTo: "http://localhost:3000"
        }
    });
    localStorage.setItem("needsReload", "yes");
};
