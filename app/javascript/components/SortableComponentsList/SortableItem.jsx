import React from "react";
import {SortableElement} from 'react-sortable-hoc'
import EditSectionButton from './EditSectionButton'
import ShowSectionButton from "./ShowSectionButton";
import DeleteSectionButton from "./DeleteSectionButton";

const SortableItem = SortableElement(({item}) => (
    <div className="card sortable-item section-card mr-4">
        <div className="inner-item card-body">
            <h4>{item.title}</h4>
            <div>{item.description}</div>
        </div>
        <div className={"card-footer"}>
            <ShowSectionButton section={item} />
            <EditSectionButton section={item} />
            <DeleteSectionButton section={item} />
        </div>
    </div>
))

export default SortableItem
