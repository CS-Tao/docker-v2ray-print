var qrcode = require('qrcode-terminal')

if (process.argv.length < 2) {
  console.error('参数错误')
  process.exit(1)
}

var urls = process.argv
  .filter((arg, index) =>
    index > 1 && arg.match(/vmess:.\/\/*?/)
  )
  .map(url => {
    return url.replace('\r', '')
  })

urls.forEach(url => {
  console.log('---------------------------- QR Code --------------------------')
  qrcode.generate(url, {small: true})
  console.log("-------------------------- Vmess link -------------------------")
  console.log(url)
})
  
if (urls.length > 1) {
  console.log('---------------------------- QR Code --------------------------')
  qrcode.generate(urls.join('\n'), {small: true})
  console.log("-------------------------- Vmess links -------------------------")
  console.log(urls.join('\n'))
  console.log()
}
