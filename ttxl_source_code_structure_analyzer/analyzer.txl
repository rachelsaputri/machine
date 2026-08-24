program source_structure_analyzer

context (file, config)

% Define the main transformation pipeline
rule main_transform(file, config) -> report
  parse_input(file) -> parsed_ast
  extract_functions(parsed_ast) -> functions
  extract_classes(parsed_ast) -> classes
  extract_variables(parsed_ast) -> variables
  extract_control_structures(parsed_ast) -> control_structures
  build_dependency_graph(functions, classes, control_structures) -> dep_graph
  construct_report(functions, classes, variables, control_structures, dep_graph, config) -> report
end

rule parse_input(file) -> ast
  % TXL parsing directive for a generic source file
  context (file, parse_context)
  match file : source_code_file
  return build_ast(parse_context)
end

rule extract_functions(ast) -> functions_list
  context (ast, function_extractor)
  find all function_declaration in ast -> functions_list
  return functions_list
end

rule extract_classes(ast) -> class_list
  context (ast, class_extractor)
  find all class_declaration in ast -> class_list
  return class_list
end

rule extract_variables(ast) -> var_list
  context (ast, var_extractor)
  find all variable_declaration in ast -> var_list
  return var_list
end

rule extract_control_structures(ast) -> ctrl_struct_list
  context (ast, ctrl_extractor)
  find all if_statement, while_statement, for_statement in ast -> ctrl_struct_list
  return ctrl_struct_list
end

rule build_dependency_graph(functions, classes, ctrl_structures) -> dep_graph
  context (functions, classes, ctrl_structures, graph_builder)
  initialize_dependency_graph() -> graph
  for each func in functions do
    find called_functions_in(func) -> callees
    add_edges(graph, func, callees)
  end
  for each class in classes do
    find referenced_classes_in(class) -> refs
    add_edges(graph, class, refs)
  end
  return graph
end

rule construct_report(functions, classes, variables, ctrl_structures, dep_graph, config) -> report
  context (functions, classes, variables, ctrl_structures, dep_graph, config, report_generator)
  format_report(functions, classes, variables, ctrl_structures, dep_graph, config) -> formatted_report
  return formatted_report
end
