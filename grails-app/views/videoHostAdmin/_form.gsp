<div class="control-group ${hasErrors(bean: videoHostInstance, field: 'name', 'error')}">
    <label class="control-label" for="name">Name</label>

    <div class="controls">
        <g:textField name="name" value="${videoHostInstance?.name}" class="input-xxlarge"/>
    </div>
</div>

<div class="control-group ${hasErrors(bean: videoHostInstance, field: 'embedTemplate', 'error')}">
    <label class="control-label" for="embedTemplate">HTML Template</label>

    <div class="controls">
        <g:textArea cols="50" rows="15" class="CodeMirror CodeMirror-scroll" id="embedTemplate" name="embedTemplate" value="${videoHostInstance?.embedTemplate}"/>

        <div class="hint">${"\${videoId}"}, ${"\${width}"} and ${"\${height}"} should appear in the template</div>
    </div>
</div>

<asset:script>
$(function() {
    CodeMirror.defineMode("gsp", function(config, parserConfig) {
        var gspOverlay = {
            token: function(stream, state) {
                var ch;
                if (stream.match("<%= '${' %>")) {
                    return "gsp";
                }
                while (stream.next() != null && !stream.match("}", false)) {}
                return null;
            }
        };
        return CodeMirror.overlayParser(CodeMirror.getMode(config, parserConfig.backdrop || "text/html"), gspOverlay);
    });

    var myCodeMirror = CodeMirror.fromTextArea(document.getElementById('embedTemplate'), {
        mode: 'gsp',
        extraKeys: {
            "'>'": function(cm) { cm.closeTag(cm, '>'); },
            "'/'": function(cm) { cm.closeTag(cm, '/'); }
        },
        lineNumbers: true,
        wordWrap: true
    });
})
</asset:script>
