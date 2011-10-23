function initWidget(input, min, max, value, valueChangedCallBack) {
    value = value || 0
    valueChangedCallBack = valueChangedCallBack || function() {}
    min = min || 0
    max = max || 10
    var widget_html = "<div id='gui-input'><span id='name-span' class='float-left'></span><div id='decrease-level-button' class='level-button float-left'></div><div class='float-left' id='level-container'><div id='level-1' class='level-item float-left' ></div><div id='level-2' class='level-item float-left'></div><div id='level-3' class='level-item float-left'></div><div id='level-4' class='level-item float-left'></div><div id='level-5' class='level-item float-left'></div><div id='level-6' class='level-item float-left'></div><div id='level-7' class='level-item float-left'></div><div id='level-8' class='level-item float-left'></div><div id='level-9' class='level-item float-left'></div><div id='level-10' class='level-item float-left'></div></div><div class='level-button float-left' id='increase-level-button'></div></div>"
    var skill_name = $(input).attr('name')
    $(input).wrap('<div id=skill-widget-' + skill_name + '></div>').after(widget_html)
    $(input).val(value)
    var div_selector = '#skill-widget-' + skill_name
    $(div_selector + ' #name-span').text(skill_name)
    $(div_selector + ' .level-item:lt(' + value + ')').each(function() {
        $(this).css('background-color', 'green')
    })
    $(div_selector + ' #decrease-level-button').click(function() {
        v = parseInt($(input).val())
        console.log(v, v-1, min)
        if (v - 1 >= min) {
            $(input).val(v - 1)
            $(div_selector + ' #level-' + v).css('background-color', 'white')
        }
    })
    $(div_selector + ' #increase-level-button').click(function() {
        v = parseInt($(input).val())
        if (v + 1 <= max) {
            $(input).val(v + 1)
            $(div_selector + ' #level-' + (v+1)).css('background-color', 'green')
        }
    })
}