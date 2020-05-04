import React from "react";
import {SortableElement} from 'react-sortable-hoc'

const SortableItem = SortableElement(({item}) => (
    <div className="card sortable-item section-card mr-4">
        <div className="inner-item card-body">
            <h4>{item.title}</h4>
            <div>{item.description}</div>
        </div>
    </div>
))

export default SortableItem
