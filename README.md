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


