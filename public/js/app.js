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

window.onload = async () => {
    console.info("Onload");
    await configureClient();

    checkPost();

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
  console.info("Update1");

  const isAuthenticated = await auth0Client.isAuthenticated();

  document.getElementById("btn-logout").disabled = !isAuthenticated;
  document.getElementById("btn-login").disabled = isAuthenticated;

  // NEW - add logic to show/hide gated content after authentication
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
    if (user.email != null) {
      try{
        document.getElementById("agentinput").value = user.email; console.info("agentinput1");
      } catch {}
      document.getElementById("userinput").value = user.email; console.info("userinput1");
    } else {
      document.getElementById("userinput").value = "none"; console.info("userinput2");
    }

    userEmail = user.email;

  } else {
    document.getElementById("gated-content").classList.add("hidden");
  }
};

const checkPost = async () => {
  console.info("Check");
  if (localStorage.getItem("needsReload") == null) {
      localStorage.setItem("needsReload", "yes");
      console.info(localStorage.getItem("needsReload") + "Yes");
  }
  if (localStorage.getItem("needsReload") == "no") {
      localStorage.setItem("needsReload", "yes");
      console.info(localStorage.getItem("needsReload") + "Yes");
  }
}

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
};

const logout = async () => {
  console.info("Log out");
  auth0Client.logout({
      logoutParams: {
          returnTo: "http://localhost:3000"
      }
  });
  localStorage.setItem("needsReload", "yes");
};


