import os
from assnake.core.Result import Result

result = Result.from_location(
    name='decontam_freq',
    description='Identify contaminants in microbiome datasets using frequency-based method.',
    result_type='analysis',
    input_type='phyloseq',
    with_presets=False,
    preset_file_format='yaml',
    location=os.path.dirname(os.path.abspath(__file__)))