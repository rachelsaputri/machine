(*
 * transformer.sml
 *
 * Functions for transforming data.
 * Applies various transformations such as filtering, mapping, and aggregation.
 *)

structure Transformer = struct
    structure Parser = Parser

    (* Filter records by value range *)
    fun filterByValueRange records lower upper =
        List.filter (fn record =>
            lower <= record.value andalso record.value <= upper
        ) records

    (* Map records to a new field *)
    fun mapRecords records mappingFunction =
        List.map mappingFunction records

    (* Aggregate records by name *)
    fun aggregateByValue records =
        let
            (* Sort records by name for grouping *)
            val sortedRecords = List.sortWith (fn (r1, r2) => String.compare (r1.name, r2.name) = LESS) records

            (* Group records by name *)
            fun groupBy' [] = []
              | groupBy' (r :: rs) =
                let
                    fun collectAccum (name, acc, remaining) =
                        case remaining of
                            {name = n, ...} :: _ =>
                                if n = name then
                                    collectAccum (name, r :: acc, remaining)
                                else
                                    (List.rev (r :: acc), remaining)
                          | [] => (List.rev (r :: acc), [])

                    val (group, rest) = collectAccum (r.name, [], rs)
                in
                    group :: groupBy' rest
                end

            val groupedRecords = groupBy' sortedRecords

            (* Aggregate each group *)
            fun aggregateGroup group =
                let
                    val totalValue = foldl (fn (record, acc) => record.value + acc) 0.0 group
                    val averageValue = totalValue / real (length group)
                in
                    (List.nth (group, 0), averageValue) (* Return first record name and average value *)
                end

            val aggregatedRecords = List.map aggregateGroup groupedRecords
        in
            aggregatedRecords
        end
end
