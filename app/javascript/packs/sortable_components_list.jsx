import React from "react";
import ReactDOM from "react-dom";
import arrayMove from 'array-move'

import SortableList from "../components/SortableComponentsList/SortableList";
import createCourseSectionsChannel from "../channels/course_sections_channel";

class SortableComponent extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            items: this.props.items,
            isConnected: props.channel.connected,
            wasDisconnected: props.channel.hasConnectionError,
            isRejected: props.channel.isRejected
        }

        props.channel.receivedDelegate = this.updateData.bind(this)
        props.channel.rejectedDelegate = this.rejectedConnection.bind(this)
        props.channel.disconnectedDelegate = this.disconnected.bind(this)
    }

    updateData = (newData) => {
        this.setState({
            items: newData
        })
    }

    rejectedConnection = () => {
        this.setState({
            isConnected: false,
            isRejected: true
        })
    }

    disconnected = () => {
        this.setState({
            isConnected: false,
            wasDisconnected: true
        })
        $("#sortableListConnectionInfo").addClass('show')
    }

    shouldCancelStart(e) {
        // Cancel sorting if the event target is an anchor tag (`a`)
        if (e.target.tagName.toLowerCase() === 'a') {
            return true; // Return true to cancel sorting
        }
    }

    onSortEnd = ({oldIndex, newIndex}) => {
        if (oldIndex === newIndex) {
            return
        }
        this.props.channel.moveSection(oldIndex, newIndex)
        this.setState({
            items: arrayMove(this.state.items, oldIndex, newIndex)
        });
    };

    render() {
        return (
            <SortableList
                items={this.state.items}
                onSortEnd={this.onSortEnd}
                shouldCancelStart={this.shouldCancelStart}
                axis="xy"
                helperClass="SortableHelper"
                hasConnectionError={this.state.wasDisconnected || this.state.isRejected}
                isConnected={this.state.isConnected}
            />
        );
    }
}

document.addEventListener('DOMContentLoaded', () => {
    let targetNode = document.getElementById('sortableCourseSections')
    let data = JSON.parse(targetNode.getAttribute('data'))
    let courseID = targetNode.getAttribute('data-course-id')
    let channel = createCourseSectionsChannel(courseID)
    ReactDOM.render(<SortableComponent items={data} channel={channel} />, targetNode)
})
