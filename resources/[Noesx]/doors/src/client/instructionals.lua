local Scaleforms = exports["meta_libs"]:Scaleforms()
Instructional = {}

Instructional.Init = function()
  local scaleform = Scaleforms.LoadMovie('INSTRUCTIONAL_BUTTONS')

  Scaleforms.PopVoid(scaleform,'CLEAR_ALL')
  Scaleforms.PopInt(scaleform,'SET_CLEAR_SPACE',200) 

  return scaleform
end

Instructional.SetControls = function(scaleform,controls)
  local i = 0
  for k,v in pairs(controls) do
    i = i + 1
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(i-1)
    for k=1,#v.codes,1 do
      ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(0, v.codes[k], true))
    end
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(v.text)
    EndTextCommandScaleformString()
    PopScaleformMovieFunctionVoid()
  end

  Scaleforms.PopVoid(scaleform,'DRAW_INSTRUCTIONAL_BUTTONS')
  --Scaleforms.PopMulti(scaleform,'SET_BACKGROUND_COLOUR',1,1,1,1)
end

Instructional.Create = function(controls)
  local scaleform = Instructional.Init()
  Instructional.SetControls(scaleform,controls)
  return scaleform
end