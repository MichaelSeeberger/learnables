import React from "react";
import {SortableElement} from 'react-sortable-hoc'
import EditSectionButton from './EditSectionButton'

const SortableItem = SortableElement(({item}) => (
    <div className="card sortable-item section-card mr-4">
        <div className="inner-item card-body">
            <h4>{item.title}</h4>
            <div>{item.description}</div>
        </div>
        <div className={"card-footer"}><EditSectionButton distance={1} section={item} /></div>
    </div>
))

export default SortableItem
