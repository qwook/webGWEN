
gwen =
    currentframe: null
    type: 0
    startfx: 0
    startfy: 0
    startcx: 0
    startcy: 0

$(document)
    .mousemove (e) ->
        if gwen.currentframe?
            if gwen.type == 1
                gwen.currentframe.css
                    top: e.pageY - gwen.startcy + gwen.startfy
                    left: e.pageX - gwen.startcx + gwen.startfx
            else
                gwen.currentframe.css
                    height: e.pageY - gwen.startcy + gwen.startfy
                    width: e.pageX - gwen.startcx + gwen.startfx
    .mouseup (e) ->
        if gwen.currentframe?
            gwen.currentframe = null


$gwen = (classname)->
    $("<div class='gwen #{classname}'><div>")

elempos = (elem)->

    elem

$.fn.moveTo = (selector)->
    return this.each ->
        cl = $(this).clone()
        $(cl).appendTo(selector)
        $(this).remove()
    

$.fn.GwenFrame = (options) ->
    settings = $.extend
        x : 0
        y : 0
        width: 200
        height: 200
        options
    
    ret = $()
    this.each ->
        $this = $(this)

        content = $("<div class='content'></div>")
        frame = $gwen("frame")
            .append($gwen("top-bg"))
            .append($gwen("bottom-bg"))
            .append($gwen("left-bg"))
            .append($gwen("right-bg"))
            .append($gwen("top-left-bg"))
            .append($gwen("top-right-bg"))
            .append($gwen("bottom-left-bg"))
            .append($gwen("bottom-right-bg"))
            .append($gwen("center-bg"))
            .append($("<div class='top-left-bg'></div>"))
            .append($("<div class='top-right-bg'></div>"))
            .append($("<div class='bottom-left-bg'></div>"))
            .append($("<div class='bottom-right-bg'></div>"))
            .append($("<div class='center-bg'></div>"))
            .append(content)
            .css
                top: settings.y,
                left: settings.x,
                width: settings.width,
                height: settings.height,
                'margin-right': -settings.width
                'margin-bottom': -settings.height
            .insertAfter($this)
            .append($this)

        frame.mousedown (e) ->
            $this = $(this)
            $this.parent().append($this)
            offset = $this.offset()
            x = e.pageX - offset.left
            y = e.pageY - offset.top
            height = $this.height()
            width = $this.width()

            if y <= 25
                gwen.type = 1
                gwen.currentframe = frame
                position = frame.position()
                gwen.startfx = position.left
                gwen.startfy = position.top
                gwen.startcx = e.pageX
                gwen.startcy = e.pageY
                return false

            if y >= height - 10 && x >= width - 10
                gwen.type = 2
                gwen.currentframe = frame
                position = frame.position()
                gwen.startfx = width
                gwen.startfy = height
                gwen.startcx = e.pageX
                gwen.startcy = e.pageY
                return false
            
        this.content = content
        
    this.each ->
        this.content.append($(this))

$(".gwenframe").GwenFrame
    'x': 5,
    'y': 5
    
$(".gwenframe_smaller").GwenFrame
    'x': 5,
    'y': 10,
    'width': 50,
    'height': 100

