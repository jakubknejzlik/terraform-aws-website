const path = require('path');

exports.handler = (event, context, callback) => {
  const request = event.Records[0].cf.request;
  const userAgent = getHeader(request, 'User-Agent');

  console.log('before', userAgent, '=>', JSON.stringify(request));

  const domain = getDomain(request);
  if (!domain) {
    return callback(null, request);
  }

  if (userAgent == 'Amazon CloudFront') {
    // handle origin request
    const bucketName = domain.replace('.s3.amazonaws.com', '');
    let newURI = request.uri.replace(`.${bucketName}/`, '/');
    if (newURI.indexOf(`/${bucketName}/`) === 0) {
      newURI = newURI.replace(`/${bucketName}/`, '/master/');
    }
    request.uri = newURI;
  } else {
    // handle viewer request
    if (path.extname(request.uri) === '') {
      request.uri = path.join(request.uri, 'index.html');
    }
    request.uri = '/' + domain + request.uri;
  }
  console.log('after', userAgent, '=>', JSON.stringify(request));
  callback(null, request);
};

function getDomain(request) {
  const host = getHeader(request, 'Host');
  const parts = host.split('.');
  return parts.join('.');
}

function getHeader(request, header) {
  const item = request.headers[header.toLowerCase()].find(
    item => item.key === header
  );
  return item && item.value;
}
