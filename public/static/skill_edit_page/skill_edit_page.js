($(function() {
    var tags = ['Python', 'Django', 'Ruby', 'Functional programming', 'Declarative programming', 'Ruby on Rails', 'Qt', 'PyQt']
    var skills = [
        {text:'C++', value:'cplusplus'},
        {text:'JavaScript', value:'javascript'},
        {text:'Database Architect', value:'databasearchitect'},
        {text:'lisp', value:'lisp'},
        {text:'SQL', value:'sql'},
        {text:'Mongo', value:'mongo'}
    ]
//settings up remove tag event
    $('.remove-image-container').live('click', function() {
        $(this).parent().hide(500, function() {
            $(this).remove();
        });
    })
//settings up popups forms
    $('#interest-select').autocomplete(tags, {matchContains:true, minChars:2})
    $('#skill-select').autocomplete(skills, {matchContains:true,
        minChars:1,
        formatItem:function(row) {
            return row.text
        },
        formatMatch:function(row) {
            return row.text
        }
    })
    $('#interest-select').result(function(event, data, value) {
        $('#interest-val').val(value)
    });
    $('#skill-select').result(function(event, data, value) {
        $('#skill-val').val(data.value)
    });
    function onLoadPopup() {
        this.getExposed().show().center().find('input:visible').focus();
    }

    function onClosePopup() {
        this.getExposed().hide().find('input').text('').val('').next().val('')
    }

    function addInterestTag() {
        var interest = $('#interest-val').val()
        if (interest)
            $('#interests-list').append(" <li class='interest'><span><a class='interest-link' href='#'>" + interest + "</a></span><div class='remove-image-container'> <img class='remove-image' src='../img/delete.png' alt='x'> </div> </li>")
        $.mask.close()
        $('#interest-val').val('')
    }

    $('#add-interest-form').submit(function(e) {
        e.preventDefault();
        addInterestTag()
    })
    function addNewSkill() {
        var skill_name = $('#skill-val').val()
        if (skill_name)
            $('#skill-list').append($("<input type='hidden' class='skill'>").text($('#skill-select').val()).attr('name', skill_name))
        initSkillLevelWidget($('input:hidden:last'), {value:1})
        $.mask.close()
        $('#interest-val').val('')
    }

    $('#save-new-interest-link').click(addInterestTag)
    $('#save-new-skill-link').click(addNewSkill)
    $('.button-cancel').click(function() {
        $.mask.close()
    })
    $('#add-interest-button').click(function() {
        $('#interest-input-popup').expose(
            {
                onLoad:onLoadPopup,
                onClose:onClosePopup
            })
    })
    $('#add-skill-button').click(function() {
        $('#skill-input-popup').expose(
            {
                onLoad:onLoadPopup,
                onClose:onClosePopup
            })
    })
}))