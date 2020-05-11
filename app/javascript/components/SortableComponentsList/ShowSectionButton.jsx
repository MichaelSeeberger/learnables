import React from "react";

function ShowSectionButton(props) {
    return <a className={"btn btn-sm btn-edit"} href={"/courses/" + props.section.course_id + "/sections/" + props.section.id + "/"}>Show</a>
}

export default ShowSectionButton