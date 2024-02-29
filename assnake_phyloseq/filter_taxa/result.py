import os
from assnake.core.Result import Result

result = Result.from_location(
    name='filter-taxa',
    description='Filter samples in a phyloseq object based on a minimum read depth.',
    result_type='phyloseq',
    input_type='phyloseq',
    with_presets=False,
    preset_file_format=None,
    location=os.path.dirname(os.path.abspath(__file__)))