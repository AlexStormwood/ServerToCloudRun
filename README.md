# ServerToCloudRun
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


5. Create a project on Google Cloud Platform.


6. Create a service account for your new GCP project.


7. Create & download a key for that service account. Make sure it's a JSON file!


8. Set up some repository secret variables based on the key.
https://github.com/{YourGithubUsernameHere}/{YourRepoNameHere}/settings/secrets/actions

Your repo needs these keys:

- A key named GCP_PROJECT with value of your project ID. For example, this demo project's ID is "expressjsdockerdeploydemo2021". Find your project ID in the project dashboard, on a page like this:


- A key named GCP_SA_KEY with the value of the contents of that JSON key file you made in the previous numbered step. Open the JSON file in your favourite text editor, select everything, copy it, and paste it in as the value.

9. Re-run the workflow from the repository's web browser interface, or just make a minor change & commit it back up to Github to trigger the workflow.

