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
                   mc-on-click='goTo(v.name.replace(/"/g, "").replace(/\//g, "-"), k)'>
                     {v.name.replace(/"/g, "").replace(/\//g, "-")}
                </a>
            </li>

        </ul>
    </div>

    

    <div mc-for="v in scope.doc.doc.children" mc-id='v.name.replace(/"/g, "").replace(/\//g, "-")'>
        <header >
            <h5><small class="label">{v.name.replace(/"/g, "").replace(/\//g, "-")}</small></h5>
        </header>
        <!--<pre mc-for="d in v.children" mc-if="['Class', 'Function', 'Variable', 'Object literal'].indexOf(d.kindString) === -1">
            {JSON.stringify(d, null, 4)}
        </pre>-->
        <div class="card" mc-for="d in v.children" mc-if="['Class', 'Function', 'Variable', 'Object literal'].indexOf(d.kindString) !== -1 && d.flags.isExported">
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
                        <div class="method-title">
                            {d.name} (
                                <span mc-for="p, k in d.signatures[0].parameters" class="property"> 
                                    {p.name} <span class="label">: {p.type.name || 'any'}</span>
                                    <i mc-if="k != d.signatures[0].parameters.length - 1">, </i>
                                </span>)
                            <span mc-if="d.signatures[0] && d.signatures[0].comment"> {d.signatures[0].comment.shortText} </span>
                            
                        </div>

                        <ul mc-for="s in d.signatures">
                            <li mc-for="p in s.parameters" mc-if="p.comment">
                                <span class="property"> {p.name} </span>
                                <span class="label">{p.type.name || 'any'}</span>
                                <span > - {p.comment ? p.comment.text : ''}</span>
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
                    <div mc-for="dc in d.children" mc-if="dc.kindString === 'Module'">
                        继承 Extend : {dc.name}
                    </div>

                    <label class="form-switch">
                        <input type="checkbox" mc-on-change="toggleInheritedFrom(d)" mc-checked="d.showInheritedFrom">
                        <i class="form-icon"></i> 隐藏继承
                    </label>
                </div>

                <dl mc-if="d.kindString === 'Class' || d.kindString === 'Object literal'">
                    
                    <dt mc-if="d.kindString === 'Class'">
                        属性 Property :
                    </dt>
                    <!--<pre>
                        {JSON.stringify(d, null, 4)}
                    </pre>-->

                    <dd mc-if="d.kindString === 'Class'">
                        <ul>
                            <li mc-for="dc in d.children" mc-if="dc.kindString === 'Property' && dc.flags.isExported && (!d.showInheritedFrom || !dc.inheritedFrom)">
                                <div mc-if="dc.inheritedFrom" class="float-right">
                                    <span class="label" mc-if="dc.inheritedFrom">继承自:</span> {dc.inheritedFrom.name}
                                </div>
                                <span class="property">
                                {dc.name}
                                </span>
                                
                                <span class="label">{dc.type.name}</span>

                                <span mc-if="dc.comment">
                                    - {dc.comment.shortText}
                                </span>
                            </li>
                        </ul>
                    </dd>
                    <dt mc-if="d.kindString === 'Class'">
                        方法 Method:
                    </dt>
                    <dd>
                        <ul>
                            <li mc-for="dc in d.children" 
                                class="method"
                                mc-if="-1 !== ['Method', 'Constructor', 'Function'].indexOf(dc.kindString) && dc.flags.isExported && (!d.showInheritedFrom || !dc.inheritedFrom || dc.kindString === 'Constructor')">
                                <div mc-if="dc.inheritedFrom && dc.kindString !== 'Constructor'" class="float-right">
                                    <span class="label" mc-if="dc.inheritedFrom">继承自:</span> {dc.inheritedFrom.name}
                                </div>
                                <div class="method-title">
                                    {dc.name} (
                                        <span mc-for="p, k in dc.signatures[0].parameters" class="property"> 
                                            {p.name} <span class="label">: {p.type.name || 'any'}</span>
                                            <i mc-if="k != dc.signatures[0].parameters.length - 1">, </i>
                                        </span>)

                                    <span mc-if="dc.signatures[0] && dc.signatures[0].type" class="label"> -> {dc.signatures[0].type.name}</span>
                                    <br>
                                    <span mc-if="dc.signatures[0] && dc.signatures[0].comment" class="comment"> {dc.signatures[0].comment.shortText} </span>
                                </div>

                                <ul mc-for="s in dc.signatures">
                                    <li mc-for="p in s.parameters" mc-if="p.comment && p.comment.text">
                                        <span class="property"> {p.name} </span>
                                        <span class="label">{p.type.name || 'any'}</span>
                                        <span > - {p.comment ? p.comment.text : ''}</span>
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
                    </dd>
                </dl>
                
            </div>
        </div>
    </div>

 
</div>