# Server Automated Deployment To Google Cloud Run
 Example of an ExpressJS web server being bundled into a Docker image & deployed to Google Cloud Run with some sweet automated workflows.

You can either read this and learn what it's doing at a conceptual level, or you can follow the Broad-level Steps below to copy what this repo is doing. 

Note that this repo is showing deployment of an ExpressJS web server -- but the real magic comes from the Github Actions workflow file which builds Docker images & pushes them to Google Cloud's container registry & Cloud Run systems.

## Broad-level Steps

1. Make sure your app runs locally.
WSL users can skip this step if networking/forwarding issues are causing things like localhost to be unreachable in your web browser. WSL2 has problems, it's part of life.

2. Make sure your app runs in a Dockerfile.
If you're using an ExpressJS app, you can copy & paste the Dockerfile from this repo. It bundles up an ExpressJS server and sets its "NODE_ENV" environment variable to "production" for easy environment identification.

Make sure you build & run your Docker image locally to confirm your app works.

3. Copy & paste the "cloudrundeploy.yml" file from the ".github/workflows" directory into your repository's own ".github/workflows" directory.

4. Commit & push the repo to Github.
This will trigger the workflow & it will fail, but that's a good thing! We still need to add all sorts of credentials & do some other Google Cloud Platform setup.


5. Create a new project on Google Cloud Platform.
![](/docs/Screenshots/NewGCPProject.png)

6. Create a service account for your new GCP project.
![](/docs/Screenshots/GCPIAMMenu.png)

![](/docs/Screenshots/GCPIAMStep01.png)

![](/docs/Screenshots/GCPIAMStep02.png)

Skip the optional 3rd step.

7. Create & download a key for that service account. Make sure it's a JSON file!

![](/docs/Screenshots/GCPServiceAccountDashboard.png)

![](/docs/Screenshots/GCPServiceAccountNewKey.png)

8. Enable billing in your Google Cloud project. Yes, this may require an actual credit card. I think you may get some free credits for 12 months, but it's been years since I was a new GCP user so I'm not actually sure.

![](/docs/Screenshots/GCR_EnableBilling.png)

9. Go to the Container Registry area and enable the Container Registry API. This allows our workflow & other code to call the system to store the Docker images built by the workflow.

![](/docs/Screenshots/GCR_EnableAPI.png)

10. Add your project ID to the end of this URL and visit it in your web browser. You want to enable the Cloud Run API, which will let our workflow & other code call the system to point our latest image in the Container Registery as the app to run when a web request is received.
https://console.developers.google.com/apis/library/run.googleapis.com?project=

![](/docs/Screenshots/CloudRun_EnableAPI.png)

11. Set up some repository secret variables based on the key.
https://github.com/{YourGithubUsernameHere}/{YourRepoNameHere}/settings/secrets/actions

Your repo needs these keys:

- A key named GCP_PROJECT with value of your project ID. For example, this demo project's ID is "expressjsdockerdeploydemo2021". Find your project ID in the project dashboard, on a page like this:

![](/docs/Screenshots/GCP_ProjectID.png)

- A key named GCP_SA_KEY with the value of the contents of that JSON key file you made in the previous numbered step. Open the JSON file in your favourite text editor, select everything, copy it, and paste it in as the value.

12. Re-run the workflow from the repository's web browser interface, or just make a minor change & commit it back up to Github to trigger the workflow.

13. Check that your Cloud Run now has a service in its dashboard. If not, something went wrong in the workflow - check its logs. 

![](/docs/Screenshots/CloudRun_Dashboard.png)

14. If all is good, we need to edit the service to allow unauthenticated invocations -- fancy words for "general public access". You can still have authenticated routes & protected parts of your app, but by default the entire app requires authentication to even be viewed when hosted by Cloud Run - we need to change that.
Click on the service to go into its details, and find the "TRIGGERS" section.

![](/docs/Screenshots/CloudRun_AllowUnauthenticatedInvocations.png)



14. Test out the Cloud Run-provided domain. You can find the auto-generated URL in that same "service details" page where you edited the authentication invocation rule.

![](/docs/Screenshots/CloudRun_PublicURL.png)



15. Map a custom domain name to your app.

This whole process is a breeze if your domains are managed by Google Domains using the same email address as the account you use for GCP. It auto-detects what domains you own & instantly verifies them as yours - no waiting around!

![](/docs/Screenshots/CloudRun_CustomURL001.png)

![](/docs/Screenshots/CloudRun_CustomURL002.png)

![](/docs/Screenshots/CloudRun_CustomURL003.png)

Notice that HTTPS is already set up for you.
And, you can even specify subdomains (eg. api.cooldomain.com) here too!