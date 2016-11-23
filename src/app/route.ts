/**
* 路由
* @date 2016-10-06 16:13:10
* @author
* @link
*/

export default function (app, done = () => { }) {

    app.route('/', require('../view/index'))
       .route('/read', require('../view/read'))

    done()
}
