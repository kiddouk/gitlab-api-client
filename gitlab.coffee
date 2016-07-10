request = require 'request'

handler =
  get: (obj, name) ->
    # Simply serve the property, otherwise, mock it via a Proxy
    # and return the setId function so the user can set
    # an optional ID.
    return obj[name] if name is "id" or obj[name]?
    path = new PathSegment obj.config
    path.setPath "#{obj.completePath()}/#{name}"
    path.setId

class PathSegment
  constructor: (@config) ->

  setPath: (@path) ->
    
  setId: (@id) =>
    new Proxy(@, handler)
    
  completePath: () ->
    if @id? then "#{@path}/#{@id}" else "#{@path}"

  completeUrl: () ->
    "#{@config.baseUrl}#{@completePath()}"

  get: (qs, cb) ->
    return request.get { 
      headers: @config.headers
      url: @completeUrl()
      qs: qs
      json: true
      }, cb

  post: (data, cb) ->
    return request.post {
      headers: @config.headers
      url: @Url()
      body: data
      json: true
      }, cb


create = (token, url) ->
  root = new PathSegment
    headers:
      "PRIVATE-TOKEN": token
    baseUrl: url
    
  root.setPath '/api/v3'
  new Proxy(root, handler)

module.exports = create
  
