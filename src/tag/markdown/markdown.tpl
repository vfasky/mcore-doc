<div class="tag-markdown">
    <div class="tool">
        <div class="form-group">
            <label class="form-switch">
                <input type="checkbox" mc-on-change="changeShowSource">
                <i class="form-icon"></i> 源码
            </label>
        </div>
    </div>
    <div mc-html="scope.html" mc-hide="scope.showSource"></div>
    <div class="form-group" mc-show="scope.showSource">
        <textarea class="form-input" mc-value="scope.data"></textarea>
    </div>
</div>