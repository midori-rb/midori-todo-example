CONTENT_TYPE = {
    css: 'text/css',
    gif: 'image/gif',
    html: 'text/html',
    ico: 'image/x-icon',
    jpeg: 'image/jpeg',
    jpg: 'image/jpeg',
    js: 'text/javascript',
    json: 'application/json',
    pdf: 'application/pdf',
    png: 'image/png',
    svg: 'image/svg+xml',
    swf: 'application/x-shockwave-flash',
    tiff: 'image/tiff',
    txt: 'text/plain',
    wav: 'audio/x-wav',
    wma: 'audio/x-ms-wma',
    wmv: 'video/x-ms-wmv',
    xml: 'text/xml'
}

class AppRoute < Midori::API
  capture Errno::ENOENT do
    Midori::Response.new(status: 404, body: 'File not Found')
  end

  get '*' do
    file_path = File.join('./frontend/dist', request.params['splat'][0]).gsub(/\.\.\//, '').gsub(/\.\//, '')
    file_path = 'frontend/dist/index.html' if file_path == 'frontend/dist/'
    raise Errno::ENOENT if File.directory?(file_path)
    content_type = CONTENT_TYPE[file_path.split('.')[-1]&.to_sym] || 'text/plain'

    file = MidoriContrib::File.new(file_path, 'r')
    Midori::Response.new(status: 200,
                         header: { 'Content-Type': content_type },
                         body: file.read)
  end
end
