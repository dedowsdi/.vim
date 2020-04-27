function ddd#syntax#apply(...) abort
  for name in a:000
    call call('ddd#syntax#' . name, [])
  endfor
endfunction

function ddd#syntax#opengl()
  syn match glEnum /\v\C<GL_\w+/

  highlight link glEnum Macro
endfunction

function ddd#syntax#glm()
  syn match glmVec /\v\C<vec\d>/
  syn match glmMat /\v\C<mat\d>/
  syn match glmNamespace /\v\C<glm>/

  highlight link glmVec Type
  highlight link glmMat Type
  highlight link glmNamespace Constant
endfunction

function ddd#syntax#glfw()
  syn match glfwMacro /\v\C<GLFW_\w+/
  syn match glfwType /\v\C<GLFW\l+/

  highlight link glfwMacro Constant
  highlight link glfwType Type
endfunction

function ddd#syntax#qt()
  syn keyword qtNamespace Qt
  syn keyword qtMacro SIGNAL SLOT Q_OBJECT signals slots emit
  syn match qtMacro1 /\vQ_[A-Z_]+/
  syn keyword qtPrimitive qint8 quint8 qint16 quint16 qint32 quint32 qint64 quint64 qlonglong qulonglong
  syn match qtClass /\v<Q\u\w*>/

  highlight link qtMacro Macro
  highlight link qtMacro1 Macro
  highlight link qtClass Type
  highlight link qtPrimitive Type
  highlight link qtNamespace Constant
endfunction

function ddd#syntax#osg()
  syn keyword osgNamespaces osg osgAnimation osgDB osgFX osgGA osgManipulator osgParticle osgPresentation osgQt osgShadow osgSim osgTerrain osgText osgUI osgUtil osgViewer osgVolume osgWidget
  syn match osgSmartPointer /\v\C<(ref|observer)_ptr>/

  highlight link osgNamespaces Constant
  highlight link osgSmartPointer Type
endfunction

function ddd#syntax#sdl()
  syn match sdlType /\v\C<SDL_\w*[a-z]+\w*>/
  syn match sdlConstant /\v\C<SDL_[A-Z_]+>/
  
  highlight link sdlType Type
  highlight link sdlConstant Constant
endfunction

function ddd#syntax#mygui()
  syn keyword myguiNamespace MyGUI

  highlight link myguiNamespace Constant
endfunction

function ddd#syntax#openmw()
  syn match mwNamespace /\v\C<MW\u+\l+\w*>/
  syn match csNamespace /\v\C<CS\u+\l+\w*>/
  " Cell Container Dialogue Sound are not included
  syn keyword mwNamespaces Ai AiSequence Animation Bsa Columns Compiler Config Console ContentSelectorModel ContentSelectorView Control Controllers CS DefaultGmsts DragDropUtils ESM ESMTerrain EsmTool ESSImport Fallback Files Formatting Generator Gui HyperTextParser ICS Interpreter Launcher Loading Misc MyGUIPlugin Nif NifBullet NifOsg OIS OMW Process Resource ResourceHelpers SceneUtil ScriptTest SDLUtil Settings SFO Shader Sky Stats Terrain ToUTF8 Transformation Translation User Version VFS Video Widgets Wizard CS CSMDoc CSMFilter CSMPrefs CSMTools CSMWorld CSVDoc CSVFilter CSVPrefs CSVRender CSVTools CSVWidget CSVWorld MWBase MWClass MWDialogue MWGui MWInput MWMechanics MWPhysics MWRender MWScript MWSound MWState MWWorld
  syn match mwClass /\v\C<\u\w*\l\w*>/
  syn keyword mwClasses NPC NAME NAME32 NAME64 NAME256

  highlight link mwClass Type
  highlight link mwClasses Type
  highlight link mwNamespaces Constant
  highlight link csNamespace Constant
endfunction

function ddd#syntax#cpp()
  syn keyword cQues Ques contained
  syn cluster cCommentGroup add=cQues

  highlight link cQues Todo
endfunction

function ddd#syntax#boost_program_options()
  syn keyword boostProgramOptionsNamespace program_options
  syn keyword boostProgramOptionsClass variables_map options_description option_description positional_options_description parsed_options
  syn keyword boostProgramOptionsClass validators validation_error
  highlight link boostProgramOptionsNamespace Constant
  highlight link boostProgramOptionsClass Type
endfunction

" only a tiny part of class is included
function ddd#syntax#boost_iostreams()
  syn keyword boostIostreamsNamespace iostreams
  syn keyword boostIostreamsClass sink source
  syn keyword boostIostreamsClass stdio_filter aggregate_filter symmetric_filter finite_state_filter
  syn keyword boostIostreamsClass input_filter filtering_istream
  syn keyword boostIostreamsClass output_filter filtering_ostream
  syn keyword boostDefine WOULD_BLOCK
  syn match boostMacro /\vBOOST_[A-Z_]+/
  highlight link boostIostreamsNamespace Constant
  highlight link boostIostreamsClass Type
  highlight link boostMacro Define
  highlight link boostDefine Constant
endfunction
