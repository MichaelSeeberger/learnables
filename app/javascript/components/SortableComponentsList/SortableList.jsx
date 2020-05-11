import React from 'react'
import {SortableContainer} from "react-sortable-hoc";
import SortableItem from "./SortableItem";
import TopBand from './TopBand'

const SortableList = SortableContainer(({items, hasConnectionError, isConnected}) => (
    <div>
        <TopBand
            hasConnectionError={hasConnectionError}
            isConnected={isConnected}
        />
        <div className={"sortable-container edit-in-progress"}>
            {items.map((item, index) => (
                <SortableItem
                    key={`${item.id}`}
                    index={index}
                    item={item}
                    disabled={!isConnected || hasConnectionError}
                />
            ))}
        </div>
    </div>
))

export default SortableList
