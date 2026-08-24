program structure_validator

context (functions, classes, variables, ctrl_structures, dep_graph)

rule validate_structure(functions, classes, variables, ctrl_structures, dep_graph) -> validation_result
  check_cyclic_dependencies(dep_graph) -> cyc_result
  check_unused_functions(functions, classes, ctrl_structures) -> unused_func_result
  check_unused_classes(classes, functions, ctrl_structures) -> unused_class_result
  check_variable_definitions(variables, functions, classes) -> var_def_result
  check_control_flow_consistency(ctrl_structures, functions) -> ctrl_result
  compile_all_results(cyc_result, unused_func_result, unused_class_result, var_def_result, ctrl_result) -> validation_result
  return validation_result
end

rule check_cyclic_dependencies(dep_graph) -> cyc_result
  context (dep_graph, cycle_detector)
  detect_cycles_in_graph(dep_graph) -> cycles
  if cycles exist then
    report_critical_issue("Cyclic dependencies detected")
    return FAILURE
  else
    report_info("No cyclic dependencies")
    return SUCCESS
  end
end

rule check_unused_functions(functions, classes, ctrl_structures) -> unused_func_result
  context (functions, classes, ctrl_structures, usage_analyzer)
  find_all_calls(functions, classes, ctrl_structures) -> all_calls
  for each func in functions do
    if func not in all_calls then
      report_warning("Unused function: " + func.name)
    end
  end
  if any_warnings then
    return WARNING
  else
    return SUCCESS
  end
end

rule check_unused_classes(classes, functions, ctrl_structures) -> unused_class_result
  context (classes, functions, ctrl_structures, usage_analyzer)
  find_all_references(classes, functions, ctrl_structures) -> all_refs
  for each cls in classes do
    if cls not in all_refs then
      report_warning("Unused class: " + cls.name)
    end
  end
  if any_warnings then
    return WARNING
  else
    return SUCCESS
  end
end

rule check_variable_definitions(variables, functions, classes) -> var_def_result
  context (variables, functions, classes, def_checker)
  for each var in variables do
    if not is_properly_declared(var) then
      report_critical_issue("Improperly declared variable: " + var.name)
    end
  end
  if any_critical_issues then
    return FAILURE
  else
    return SUCCESS
  end
end

rule check_control_flow_consistency(ctrl_structures, functions) -> ctrl_result
  context (ctrl_structures, functions, flow_checker)
  for each ctrl in ctrl_structures do
    if not is_logically_consistent(ctrl) then
      report_warning("Inconsistent control flow in: " + ctrl.parent)
    end
  end
  if any_warnings then
    return WARNING
  else
    return SUCCESS
  end
end

rule compile_all_results(cyc_result, unused_func_result, unused_class_result, var_def_result, ctrl_result) -> validation_result
  context (cyc_result, unused_func_result, unused_class_result, var_def_result, ctrl_result, result_compiler)
  initialize_validation_report()
  append_result(cyc_result)
  append_result(unused_func_result)
  append_result(unused_class_result)
  append_result(var_def_result)
  append_result(ctrl_result)
  return get_validation_report()
end
