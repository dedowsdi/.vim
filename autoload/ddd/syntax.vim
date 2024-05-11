function ddd#syntax#apply(...) abort
  for name in a:000
    call call('ddd#syntax#' . name, [])
  endfor
endfunction

function ddd#syntax#opengl()
  syn match glEnum /\v\C<GL_\w+/

  hi link glEnum Macro
endfunction

function ddd#syntax#glm()
  syn match glmVec /\v\C<vec\d>/
  syn match glmMat /\v\C<mat\d>/
  syn match glmNamespace /\v\C<glm>/

  hi link glmVec Type
  hi link glmMat Type
  hi link glmNamespace Constant
endfunction

function ddd#syntax#glfw()
  syn match glfwMacro /\v\C<GLFW_\w+/
  syn match glfwType /\v\C<GLFW\l+/

  hi link glfwMacro Constant
  hi link glfwType Type
endfunction

function ddd#syntax#qt()
  syn keyword qtNamespace Qt
  syn keyword qtMacro SIGNAL SLOT Q_OBJECT signals slots emit
  syn match qtMacro1 /\vQ_[A-Z_]+/
  syn keyword qtPrimitive qint8 quint8 qint16 quint16 qint32 quint32 qint64 quint64 qlonglong qulonglong
  syn match qtClass /\v<Q\u\w*>/

  hi link qtMacro Macro
  hi link qtMacro1 Macro
  hi link qtClass Type
  hi link qtPrimitive Type
  hi link qtNamespace Constant
endfunction

function ddd#syntax#osg()
  " syn keyword osgNamespaces osg osgAnimation osgDB osgFX osgGA osgManipulator
  "       \ osgParticle osgPresentation osgQt osgShadow osgSim osgTerrain
  "       \ osgText osgUI osgUtil osgViewer osgVolume osgWidget

  syn match osgSmartPointer /\v\C<(ref|observer)_ptr>/

  " hi link osgNamespaces Constant
  hi link osgSmartPointer Type
endfunction

function ddd#syntax#sdl()
  syn match sdlType /\v\C<SDL_\w*[a-z]+\w*>/
  syn match sdlConstant /\v\C<SDL_[A-Z_]+>/
  
  hi link sdlType Type
  hi link sdlConstant Constant
endfunction

function ddd#syntax#mygui()
  syn keyword myguiNamespace MyGUI

  hi link myguiNamespace Constant
endfunction

function ddd#syntax#openmw()
  syn match mwNamespace /\v\C<MW\u+\l+\w*>/
  syn match csNamespace /\v\C<CS\u+\l+\w*>/
  " Cell Container Dialogue Sound are not included
  syn keyword mwNamespaces Ai AiSequence Animation Bsa Columns Compiler Config Console ContentSelectorModel ContentSelectorView Control Controllers CS DefaultGmsts DragDropUtils ESM ESMTerrain EsmTool ESSImport Fallback Files Formatting Generator Gui HyperTextParser ICS Interpreter Launcher Loading Misc MyGUIPlugin Nif NifBullet NifOsg OIS OMW Process Resource ResourceHelpers SceneUtil ScriptTest SDLUtil Settings SFO Shader Sky Stats Terrain ToUTF8 Transformation Translation User Version VFS Video Widgets Wizard CS CSMDoc CSMFilter CSMPrefs CSMTools CSMWorld CSVDoc CSVFilter CSVPrefs CSVRender CSVTools CSVWidget CSVWorld MWBase MWClass MWDialogue MWGui MWInput MWMechanics MWPhysics MWRender MWScript MWSound MWState MWWorld
  syn match mwClass /\v\C<\u\w*\l\w*>/
  syn keyword mwClasses NPC NAME NAME32 NAME64 NAME256

  hi link mwClass Type
  hi link mwClasses Type
  hi link mwNamespaces Constant
  hi link csNamespace Constant
endfunction

function ddd#syntax#cpp()
  syn keyword cQues Ques contained
  syn cluster cCommentGroup add=cQues

  " syn keyword cppNamespace std

  syn keyword cppSmartPointer unique_ptr shared_ptr weak_ptr

  syn keyword cppVariousCast static_pointer_cast dynamic_pointer_cast
        \ const_pointer_cast reinterpret_pointer_cast forward move

  syn keyword cppSmartInit make_shared make_unique

  hi link cQues Todo
  " hi link cppNamespace Constant
  hi link cppSmartPointer Type
  hi link cppVariousCast Statement
  hi link cppSmartInit Function
endfunction

function ddd#syntax#boost_program_options()
  syn keyword boostProgramOptionsNamespace program_options
  syn keyword boostProgramOptionsClass variables_map options_description option_description positional_options_description parsed_options
  syn keyword boostProgramOptionsClass validators validation_error
  hi link boostProgramOptionsNamespace Constant
  hi link boostProgramOptionsClass Type
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
  hi link boostIostreamsNamespace Constant
  hi link boostIostreamsClass Type
  hi link boostMacro Define
  hi link boostDefine Constant
endfunction
