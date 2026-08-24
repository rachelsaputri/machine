program structure_reporter

context (functions, classes, variables, ctrl_structures, dep_graph, config)

rule generate_json_report(functions, classes, variables, ctrl_structures, dep_graph, config) -> json_output
  initialize_json_writer(config) -> writer
  write_header(writer, config) -> writer
  write_functions_section(writer, functions) -> writer
  write_classes_section(writer, classes) -> writer
  write_variables_section(writer, variables) -> writer
  write_control_structures_section(writer, ctrl_structures) -> writer
  write_dependency_graph_section(writer, dep_graph) -> writer
  write_footer(writer, config) -> json_output
  return json_output
end

rule write_header(writer, config) -> writer
  context (writer, config, json_writer)
  start_json_object(writer)
  write_key(writer, "metadata")
  start_json_object(writer)
  write_key(writer, "timestamp")
  write_value(writer, get_current_timestamp())
  write_key(writer, "config")
  write_value(writer, config)
  end_json_object(writer)
  return writer
end

rule write_functions_section(writer, functions) -> writer
  context (writer, functions, json_writer)
  write_key(writer, "functions")
  start_json_array(writer)
  for each func in functions do
    start_json_object(writer)
    write_key(writer, "name")
    write_value(writer, get_func_name(func))
    write_key(writer, "parameters")
    write_value(writer, get_func_parameters(func))
    write_key(writer, "return_type")
    write_value(writer, get_func_return_type(func))
    end_json_object(writer)
  end
  end_json_array(writer)
  return writer
end

rule write_classes_section(writer, classes) -> writer
  context (writer, classes, json_writer)
  write_key(writer, "classes")
  start_json_array(writer)
  for each cls in classes do
    start_json_object(writer)
    write_key(writer, "name")
    write_value(writer, get_class_name(cls))
    write_key(writer, "superclass")
    write_value(writer, get_class_superclass(cls))
    write_key(writer, "methods")
    write_value(writer, get_class_methods(cls))
    end_json_object(writer)
  end
  end_json_array(writer)
  return writer
end

rule write_variables_section(writer, variables) -> writer
  context (writer, variables, json_writer)
  write_key(writer, "variables")
  start_json_array(writer)
  for each var in variables do
    start_json_object(writer)
    write_key(writer, "name")
    write_value(writer, get_var_name(var))
    write_key(writer, "type")
    write_value(writer, get_var_type(var))
    end_json_object(writer)
  end
  end_json_array(writer)
  return writer
end

rule write_control_structures_section(writer, ctrl_structures) -> writer
  context (writer, ctrl_structures, json_writer)
  write_key(writer, "control_structures")
  start_json_array(writer)
  for each ctrl in ctrl_structures do
    start_json_object(writer)
    write_key(writer, "type")
    write_value(writer, get_ctrl_type(ctrl))
    write_key(writer, "condition")
    write_value(writer, get_ctrl_condition(ctrl))
    end_json_object(writer)
  end
  end_json_array(writer)
  return writer
end

rule write_dependency_graph_section(writer, dep_graph) -> writer
  context (writer, dep_graph, json_writer)
  write_key(writer, "dependency_graph")
  start_json_object(writer)
  for each node in get_graph_nodes(dep_graph) do
    write_key(writer, node)
    start_json_array(writer)
    for each neighbor in get_graph_edges(dep_graph, node) do
      write_value(writer, neighbor)
    end
    end_json_array(writer)
  end
  end_json_object(writer)
  return writer
end

rule write_footer(writer, config) -> json_output
  context (writer, config, json_writer)
  end_json_object(writer)
  return writer
end
