solution_file=$1

readarray components < <(yq e -o=j -I=0 '.ImportExportXml.SolutionManifest.RootComponents |= ([] + .) | .ImportExportXml.SolutionManifest.RootComponents.[0].RootComponent[]' "$solution_file")

for component in "${components[@]}"; do
    echo $component
    type=$(echo $component | yq e '.+@type')
    schemaName=$(echo $component | yq e '.+@schemaName')
    echo "Adding $schemaName of type $type to solution"
    pac
done