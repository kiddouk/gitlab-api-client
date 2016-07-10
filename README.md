# GITLAB API CLIENT DOCUMENTATION #

Welcome to gitlab-api-client documentation. This client has been
designed to fit in as little lines as possible.

All you have to know is that :

1. This client exposes an HTTP request from the node module
   request. This means that you can use it like any `request` based
   project with a simple callback that takes `(err, response, body)`.

2. All paths are build generically. Once you understand this concept,
   you will have access to all the gitlab API endpoints, even for
   those that haven't been defined yet. Isn't life good ?
   example: `gitlab.projects().all()` builds the path `/projects/all`
   `gitlab.projects(1).repository().commits("b4da33sha1")` builds the
   path `/projects/1/repository/commits/b4da33sha1`.


With this, you can now easily build all the required API paths for
your gitlab server.

## Configuration
Prior to all this, you should configure your client to use the proper
`PRIVATE-TOKEN` and the correct url. For this, simply pass those when
you require the module.

```
gitlab = require('gitlab')('my-token', 'https://gitlab.com')
```

## GET or POST requests
Now that you have configured your client and that you know how to
build a path for any gitlab api resources, the last step is to create
a `GET` and a `POST` request.

A simple example:
```
gitlab
 .projects(1)
 .repository()
 .compare()
 .get({from: "master", to:"branch}, function(err, response, diffs) {
   console.log(JSON.stringify(diffs));
   })
```
This simple emits a `GET` request with 2 query string parameters on
the path `/projects/1/repository/compare`

If you need to make a call without querystring, make sure to pass
`undefined`.
```
gitlab
 .projects
 .all()
 .get(undefined, function(err, response, projects) {
   console.log("ALL THE PROJECTS!");
 })
 ```

as to make a `POST` request, follow the same logic:
```
gitlab
 .projects(1)
 .merge_requests()
 .post({
   source_branch: "branch",
   target_branch: "master",
   title: "A simple merge request"
   },  function(err, response, merge_request) {
   console.log(JSON.stringify(merge_request))
})
```

## Conclusion
Thanks for trying this module. I hope that you will enjoy it. Please,
report and idea, comment and bugs that you may find in the [issue
section](https://github.com/kiddouk/gitlab-api-client/issues) of this repo.

Hasta la vista !
