const http = require('http')
const fs   = require('fs')

var messages = []

function listener(req, res) {
    res.writeHead(200)
    res.write(handle_path(req.url))
    res.end()
}

var server = http.createServer(listener)
server.listen(8080)

function handle_path(path) {
    res = path

    spath = path.split('/')
    switch (spath[1]) {
        case '':
        case 'index':
            res = fs.readFileSync('index.html')
            break
        case 'chat':
            res = handle_chat(spath[2])
            break
        case 'style.css':
            res = fs.readFileSync('style.css')
            break
        case 'msg':
            if (spath[2] == 'add') {
                res = addMsg(spath[3], spath[4])
            }
            else if (spath[2] == 'read') {
                res = readMsg(spath[3])
            }
            break

        default:
            res = 'Az oldal nem talalhato!'
            break
    }

    return res
}

function handle_chat(name) {
    let res = fs.readFileSync('chat.html')
    res = res.toString().replaceAll('{{name}}', name)
    return res
}

function addMsg(name, msg) {
    messages.push([name, msg])
    return readMsg(name)
}

function readMsg(name) {
    ret = ''
    
    //console.log(messages)
    for (let i = 0; i < messages.length; i++) {
        ret += '<div class="msg">'
        ret += `<span class="${messages[i][0] == name ? 'msg-ownname' : 'msg-name'}">`
        ret +=   `${messages[i][0]}</span>: `
        ret += `<span class="msg-text">${messages[i][1]}</span>`
        ret += '</div>'
    }
    //console.log(ret)

    return ret
}
