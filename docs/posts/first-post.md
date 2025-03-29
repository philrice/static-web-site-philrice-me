---
draft: false 
date: 2025-02-06
authors: [philrice]
categories:
  - General
links:
  - posts/second-test.md
 
---

# First Post

Just setting up this blog, so this is the tradtional 'first post' just for testing purposes and to get the ball rolling. There will be some proper content coming soon :-)

Unlikely anyone / many reading this yet but if there is , this is what im working on ...

- need to adjust the mkdocs styling and navigation, add a few plugins etc  - DONE :white_check_mark:  
- need to expand the terraform ive used to depoy the Azure Static Web App this is hosted on to include/ handle the custom domain name config Ive added
- need to document the entire config in the github repo well 
- probably add branch protection rules so that only pull requests can be used to commit. There is already a github action in place that will handle deployments based on that and close the PR
- just updated the action so that it does not commit the builb of the  /site directory to the repo, as not required and we can just build and deploy. Better to not have /site in the repo as ee then need to pull to get in synch and this hinders the workflow.
- change azure subscription this is hosted on to a different one dedicated to purely homelab and lab deployments - DONE
<!-- more -->
.... oh yeah, and write some content...

I will probably write an article outlining the whole setup of this static web site, including the CI/CD pipeline, deploying the Azure Static Web app as IaC and how to tweak Mkdocs to get a look that you like.