import 'package:flutter/material.dart';

enum TaskProcessedCondition {
  hasProject,
  hasContext,
  hasBothOfProjectAndContext,
}

class PreferenceOfTask {
  static TaskProcessedCondition taskProcessedCondition = TaskProcessedCondition.hasContext;
  
}