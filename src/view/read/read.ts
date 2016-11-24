/**
* [desc]
* @date 2016-11-22 17:35:52
* @author 
* @link 
*/

import View from 'view/base'
import * as storage from 'mcore-ext/util/storage'

export default class Read extends View {

    static get viewName() {
        return 'read'
    }

    run () {
        let docJson = storage.get('docJson')
        if (!docJson) {
            window.location.href = '#/'
        }
        this.parentDoc(JSON.parse(docJson))

        this.render(require('./read.tpl'))
    }

    show (event, el, typeName: string) {
        Object.keys(this.scope.type).forEach((name) => {
            let doc = this.scope.type[name]
            doc.active = name === typeName
            if (doc.active) {
                this.setCurDoc(doc.list[0])
            }
        })
        return false
    }

    goTo (event, el, nameId: string, ix: number) {

        let $id = this.$refs.find('#' + nameId)

        this.$body.animate({
            scrollTop: $id.position().top
        })

        this.scope.ix = ix
        return false
    }

    toggleInheritedFrom (event, el, doc) {
        doc.showInheritedFrom = el.checked
    }

    setCurDoc (doc) {
        doc.doc = doc.doc || { children: []}
        this.scope.ix = 0
        // console.log(doc)
        this.scope.docTitle = doc.doc.name
        this.scope.doc = doc
    }

    parentDoc (docData) {
        this.scope.type = {}
        Object.keys(docData).filter((typeName) => {
            return docData[typeName].doc
        }).forEach((typeName, k) => {
            let types = typeName.split('/')
            let type = types.shift()
            let doc = docData[typeName]

            if (k === 0) {
                if (doc.doc) {
                    this.setCurDoc(doc)
                } else {
                    console.log(this.scope.type, typeName)
                }
            }

            if (this.scope.type.hasOwnProperty(type) === false) {
                this.scope.type[type] = {
                    active: k === 0,
                    list: []
                }
            }
            this.scope.type[type].list.push(doc)
        })
        // console.log(this.scope.type)
    }

  
}
