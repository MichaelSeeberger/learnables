import React from "react";

function DeleteSectionButton(props) {
    return (<a className={"btn btn-sm btn-delete ml-2"}
               data-confirm={'Are you sure?'}
               href={"courses/" + props.course_id + "/sections/" + props.section.id}
               data-method={"delete"}>Delete</a>)
}

export default DeleteSectionButton