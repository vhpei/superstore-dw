select
    segment_id,
    segment
from {{ source("norm", "t_segment") }}
