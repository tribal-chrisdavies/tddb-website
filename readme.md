# DDB Website

This site is built with a combination of three different techs:

- [GitHub Pages](https://pages.github.com/) using [Jekyll](https://jekyllrb.com/) (static website generator)
- [Contenful](https://www.contentful.com/) (data generator)
- [CircleCI](https://circleci.com/) (Intermediary build manager)

Jekyll is used to generate a standard static website.

Contentful is used to generate data that the website uses. Devs can manage the data types, forms and validation, while non-devs can easily create data with said forms, ready to be exported.

CircleCI is used to merge these two techs together. When data is published on Contentful, or when GitHub recieves a push, a webhook is sent to CircleCI - this makes CircleCI pull the repo down from GitHub, pull the data from Contentful, then commit and push the repo back up to GitHub.

GitHub will automatically "build" whatever Jekyll project is in the __master__ branch and host it as a static website.

Therefore, these three main tech bundles work together to create a psuedo-CMS in a static website. This allows non-devs to "update" the website's information without needing any help from the dev team.

An article for this process is available [here at Contentful](https://www.contentful.com/developers/docs/ruby/tutorials/automated-rebuild-and-deploy-with-circleci-and-webhooks/).

## Setup

- Install Ruby stuff with **bundle install**

Everything else should work fine.

## Dev Cycle

- Use **bundle exec jekyll serve** to start a localhost watcher and server. This can be accessed at **http://127.0.0.1:4000/**
- Use **bundle exec jekyll contentful** to manually pull down JSON data from Contentful

Note that GitHub pages will automatically take whatever is in the **master** branch, compile it with Jekyll (if possible), and then host it - this means that as a developer you should only be making changes in the **develop** branch, and then merging those feature-complete changes into **master** only when the site is ready for publishing.

## Non-Dev Cycle

- Log on to [app.contentful.com](https://app.contentful.com/)
- Modify data as you like
- Any time you **publish** or **unpublish** something, you will trigger a build

Note that if you publish many things in quick succession, you will trigger multiple builds that will be queued up and eventually processed over time.

The current round-time for an update is between 3-5 minutes.
