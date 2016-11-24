/**
* 首页
*/

import View from 'view/base'
import './index.scss'
import * as storage from 'mcore-ext/util/storage'

export default class Index extends View {

    static get viewName() {
        return 'index'
    }

    run () {
        this.render(require('./index.tpl'))

    }

    selectFile (event:JQueryEventObject, el:HTMLElement, files: any[]) {
        let jsonFile
        for (let file of files) {
            if (file.type === 'application/json'){
                jsonFile = file
                break
            }
        }
        if (!jsonFile) return
        let reader = new FileReader()

        reader.onload = (e: any) => {
            let jsonData = e.target.result
            storage.set('docJson', jsonData)
            window.location.href = '#/read'
        }

        reader.readAsText(jsonFile)
    }
}
