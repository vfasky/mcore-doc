/**
* [desc]
* @date 2016-11-22 15:59:50
* @link 
*/

import {Template} from 'mcore3'
import Base from '../base'

export default class DropFile extends Base {

    init () {
        this.scope.tips = this.scope.tips || 'Drop file here.'
        this.scope.maxFileTotal = this.scope.maxFileTotal || 1
        this.scope.active = false
        this.render(require('./dropFile.tpl'))
    }

    dragleave () {
        this.scope.active = false
    }

    dragover (event) {
        this.scope.active = true
        event.stopPropagation()
        event.preventDefault()
        event.originalEvent.dataTransfer.dropEffect = 'copy'
        return false
    }

    drop (event, el) {
        event.stopPropagation()
        event.preventDefault()
        this.scope.active = false
        let files = event.originalEvent.dataTransfer.files

        if (files.length) {
            this.emitEvent('change', [event, el, files])
        }

        return false
    }
    
}

Template.components['drop-file'] = DropFile