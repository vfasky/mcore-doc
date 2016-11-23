/**
* [desc]
* @date 2016-11-23 17:22:58
*/

import { Template } from 'mcore3'
import Base from '../base'
import * as marked from 'marked'
import * as highlight from 'highlight.js'
import * as $ from 'jquery'

marked.setOptions({
    pedantic: true,
    highlight: function (code, language) {
        const validLang = !!(language && highlight.getLanguage(language))
        if (validLang) {
            return highlight.highlight(language, code).value
        }
        return highlight.highlightAuto(code).value
    }
})

export default class Markdown extends Base {
    $el: JQuery

    init() {
        this.$el = $(this.el)
        this.renderMD()
        this.render(require('./markdown.tpl'))
    }

    watch () {
        this.on('update:data', () => {
            this.renderMD()
        })
    }

    changeShowSource (event, el){
        this.scope.showSource = el.checked
    }

    renderMD () {
        this.scope.html = marked(this.scope.data || '')
    }

}

Template.components['markdown'] = Markdown