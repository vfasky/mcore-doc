<div class="view-read container grid-960">
    <h4 class="text-center">{scope.docTitle} document</h4>

    <ul class="tab tab-block">
        <li class="tab-item" 
            mc-for="v, doc of scope.type" 
            mc-on-click="show(v)"
            mc-class-active="doc.active">
            <a>{v}</a>
        </li>
        
    </ul>

    <div class="fixed sidebar" mc-if="scope.doc.doc.children.length > 1">
        <ul class="menu">
            <li class="menu-header">
                <span class="menu-header-text">
                        Go to
                </span>
            </li>
            <li class="menu-item" mc-for="v, k in scope.doc.doc.children">
                <a mc-class-active="scope.ix === k"
                   mc-on-click='goTo(v.name.replace(/"/g, ""), k)'>
                     {v.name.replace(/"/g, "")}
                </a>
            </li>

        </ul>
    </div>

    <div mc-for="v in scope.doc.doc.children" mc-id='v.name.replace(/"/g, "")'>
        <header >
            <h5><small class="label">Namespace: {v.name.replace(/"/g, "")}</small></h5>
        </header>

        <div class="card" mc-for="d in v.children" mc-if="['Class', 'Function', 'Variable'].indexOf(d.kindString) !== -1 && d.flags.isExported">
            <div class="card-header">
                <h5 class="card-title">{v.name.replace(/"/g, "")}.{d.name}</h5>
                <h6 class="card-meta">{d.kindString}</h6>
            </div>
            <div class="card-body">
                <div mc-if="d.kindString === 'Variable' && d.comment">
                    
                    <div mc-for="e in d.comment.tags" mc-if="e.tag === 'example'">
                        <h6>Example : </h6>
                        <markdown mc-data="e.text"></markdown>
                    </div>
                </div>
                <ul mc-if="d.kindString === 'Function'">
                    <li mc-for="s in d.signatures">
                        <div>
                            {d.name} (
                                <span mc-for="p, k in d.signatures[0].parameters"> 
                                    {p.name} <code mc-if="p.comment">{p.comment ? p.comment.text : ''}</code>
                                    <i mc-if="k != d.signatures[0].parameters.length - 1">, </i>
                                </span>)
                            <span mc-if="d.signatures[0] && d.signatures[0].comment"> {d.signatures[0].comment.shortText} </span>
                            <!--<pre>
                                {JSON.stringify(d, null, 4)}
                            </pre>-->
                        </div>

                        <ul mc-for="s in d.signatures">
                            <li mc-for="p in s.parameters">
                                <span class="label">{p.type.name || 'any'}</span>
                                {p.name}
                                
                            </li>
                        </ul>

                        <div mc-for="comment in d.signatures" mc-if="comment.comment">
                            <div class="code" mc-for="e in comment.comment.tags" mc-if="e.tag === 'example'">
                                <h6>Example : </h6>
                                <markdown mc-data="e.text"></markdown>
                            </div>
                        </div>
                
                    </li>
                </ul>
                <div class="form-group" mc-if="d.kindString === 'Class'">
                    <label class="form-switch">
                        <input type="checkbox" mc-on-change="toggleInheritedFrom(d)" mc-checked="d.showInheritedFrom">
                        <i class="form-icon"></i> 隐藏继承
                    </label>
                </div>
                <ul mc-if="d.kindString === 'Class'">
                    <li>
                        属性 Property :
                        <ul>
                            <li mc-for="dc in d.children" mc-if="dc.kindString === 'Property' && dc.flags.isExported && (!d.showInheritedFrom || !dc.inheritedFrom)">
                                <div mc-if="dc.inheritedFrom" class="float-right">
                                    <span class="label" mc-if="dc.inheritedFrom">继承自:</span> {dc.inheritedFrom.name}
                                </div>
                                {dc.name}
                                -
                                <span class="label">{dc.type.name}</span>

                                <ul mc-if="dc.comment">
                                    <li >{dc.comment.shortText}</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        方法 Method:
                        <ul>
                            <li mc-for="dc in d.children" mc-if="dc.kindString === 'Method' && dc.flags.isExported && (!d.showInheritedFrom || !dc.inheritedFrom)">
                                <div mc-if="dc.inheritedFrom" class="float-right">
                                    <span class="label" mc-if="dc.inheritedFrom">继承自:</span> {dc.inheritedFrom.name}
                                </div>
                                <div>
                                    {dc.name} (
                                        <span mc-for="p, k in dc.signatures[0].parameters"> 
                                            {p.name} <code mc-if="p.comment && p.comment.text">{p.comment ? p.comment.text : ''}</code>
                                            <i mc-if="k != dc.signatures[0].parameters.length - 1">, </i>
                                        </span>)
                                    <span mc-if="dc.signatures[0] && dc.signatures[0].comment"> {dc.signatures[0].comment.shortText} </span>
                                </div>

                                <ul mc-for="s in dc.signatures">
                                    <li mc-for="p in s.parameters">
                                        <span class="label">{p.type.name || 'any'}</span>
                                        {p.name}
                                        
                                    </li>
                                </ul>

                                <div mc-for="comment in dc.signatures" mc-if="comment.comment">
                                    
                                    <div class="code" mc-for="e in comment.comment.tags" mc-if="e.tag === 'example'">
                                        <h6>Example : </h6>
                                        <markdown mc-data="e.text"></markdown>
                                    </div>
                                </div>
                        
                            </li>
                        </ul>
                    </li>
                </ul>
                
            </div>
        </div>
    </div>

 
</div>