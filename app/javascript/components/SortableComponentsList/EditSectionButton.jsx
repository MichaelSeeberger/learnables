import React from "react";

function EditSectionButton(props) {
    return (
        <a className={"btn btn-sm btn-edit ml-2"} href={"/courses/" + props.section.course_id + "/sections/" + props.section.id + "/edit"}>Edit</a>
    )
}

export default EditSectionButton