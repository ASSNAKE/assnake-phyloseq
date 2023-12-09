import os
from assnake.core.Result import Result

result = Result.from_location(
    name='barplot_facet',
    description='Plot a facetted barplot.',
    result_type='plot',
    input_type='phyloseq',
    with_presets=False,
    preset_file_format='yaml',
    location=os.path.dirname(os.path.abspath(__file__)))