
enum TaskProcessedCondition {
  hasProject,
  hasContext,
  hasBothOfProjectAndContext,
}

class PreferenceOfTask {
  static TaskProcessedCondition taskProcessedCondition = TaskProcessedCondition.hasContext;
  
}