import React from "react";

function EditSectionButton(props) {
    return (
        <span>
            <a className={"btn btn-sm btn-edit"}
           href={"/courses/" + props.section.course_id + "/sections/" + props.section.id + "/edit"}>Edit</a>
            <a className={"btn btn-sm btn-delete ml-2"} data-confirm={'Are you sure?'}
               href={"courses/" + props.course_id + "/sections/" + props.section.id}
               data-method={"delete"}>Delete</a>
        </span>
    )
}

export default EditSectionButton