widget_html = "<div class='gui-input'> <span class='skill-name-span float-left'> <a class='skill-name-link' href='#'></a> <span class='remove-skill-span'> <a class='remove-skill-link'>remove</a> </span> </span> <div class='gui-container'> <div class='decrease-level-button level-button float-left'></div> <div class='float-left level-container'></div> <div class='increase-level-button level-button float-left'></div> </div> </div>"
bar_html = "<div class='level-item float-left' ></div>"

function propertyDefaultGetter(hash, property, defValue) {
    if (hash.hasOwnProperty(property))
        return hash[property]
    else
        return defValue
}

function initSkillLevelWidget(input, options) {
    var value = propertyDefaultGetter(options, 'value', 1) || 1
    var onBeforeValueChanged = propertyDefaultGetter(options, 'onBeforeValueChanged', function() {
    })
    var onAfterValueChanged = propertyDefaultGetter(options, 'onAfterValueChanged', function() {
    })
    var onBeforeRemove = propertyDefaultGetter(options, 'onBeforeRemove', function() {
    })
    var onAfterRemove = propertyDefaultGetter(options, 'onAfterRemove', function() {
    })
    var onBeforeRestore = propertyDefaultGetter(options, 'onBeforeRestore', function() {
    })
    var onAfterRestore = propertyDefaultGetter(options, 'onAfterRestore', function() {
    })
    var allow_remove_label = propertyDefaultGetter(options, 'allowRemove', true)
    var min = 1
    var max = propertyDefaultGetter(options, 'max', 10)
    var skill_name = $(input).attr('name')
    var skill_text = $(input).text() || $(input).attr('text')
    $(input).wrap('<div id=skill-widget-' + skill_name + '></div>').after(widget_html)
    $(input).val(value)
    var item_div_id = '#skill-widget-' + skill_name
    $(item_div_id + ' .skill-name-link').text(skill_text)
    for (var i = min; i <= max; i++) {
        $(item_div_id + ' .level-container').append("<div class='level-item float-left' value=" + i + "></div>")
        if (i <= value) {
            $(item_div_id + ' .level-item[value=' + i + ']').addClass('level-item-achieved')
        }
    }
    $(item_div_id + ' .decrease-level-button').click(function() {
        var v = parseInt($(input).val())
        if (v - 1 >= min) {
            onBeforeValueChanged()
            $(input).val(v - 1)
            onAfterValueChanged()
            $(item_div_id + ' .level-item[value=' + v + ']').removeClass('level-item-achieved')
        }
    })
    $(item_div_id + ' .increase-level-button').click(function() {
        var v = parseInt($(input).val())
        if (v + 1 <= max) {
            onBeforeValueChanged()
            $(input).val(v + 1)
            onAfterValueChanged()
            $(item_div_id + ' .level-item[value=' + (v + 1) + ']').addClass('level-item-achieved')
        }
    })
    $(item_div_id + ' .level-item').click(function() {
        var i, v = parseInt($(this).attr('value'));
        $(item_div_id + ' .level-item:lt(' + v + ')').addClass('level-item-achieved')
        $(item_div_id + ' .level-item:gt(' + (v - 1) + ')').removeClass('level-item-achieved')
        onBeforeValueChanged()
        $(input).val($(this).attr('value'))
        onAfterValueChanged()
    })

    if (!allow_remove_label) {
        $(item_div_id + ' .remove-skill-span').remove()
    }
    else{
        $(item_div_id + ' .remove-skill-link').hide()
        $(item_div_id + ' .remove-skill-link').toggle(
            function() {
                onBeforeRemove()
                $(this).text('restore')
                $(item_div_id+ ' .skill-name-link').addClass('skill-name-link-removed')
                $(item_div_id +' .gui-container').hide(400)
                onAfterRemove()
            },
            function() {
                onBeforeRestore()
                $(this).text('remove')
                $(item_div_id+ ' .skill-name-link').removeClass('skill-name-link-removed')
                $(item_div_id +' .gui-container').show(400)
                onAfterRestore()
            })
        $(item_div_id).hover(
            function() {
                $(item_div_id + ' .remove-skill-link').show(400)
        },
            function() {
                $(item_div_id + ' .remove-skill-link').hide(400)
        })
    }
}   