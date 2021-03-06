add_subdirectory(Utils)

add_mlir_library(MLIRTransforms
  Canonicalizer.cpp
  CSE.cpp
  DialectConversion.cpp
  Inliner.cpp
  LocationSnapshot.cpp
  LoopCoalescing.cpp
  LoopFusion.cpp
  LoopInvariantCodeMotion.cpp
  MemRefDataFlowOpt.cpp
  OpStats.cpp
  PipelineDataTransfer.cpp
  StripDebugInfo.cpp
  SymbolDCE.cpp
  ViewOpGraph.cpp
  ViewRegionGraph.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Transforms

  DEPENDS
  MLIRStandardOpsIncGen
  )

target_link_libraries(MLIRTransforms
  PUBLIC
  MLIRAffine
  MLIRAnalysis
  MLIRLoopLikeInterface
  MLIRLoopOps
  MLIRPass
  MLIRTransformUtils
  MLIRVector
  )
