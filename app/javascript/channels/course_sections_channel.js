import consumer from "./consumer"

let createCourseSectionsChannel = (courseID) => {
    return consumer.subscriptions.create({channel: "CourseSectionsChannel", id: courseID}, {
        connected() {
            this.moveSection = this.moveSection.bind(this)
            this.isConnected = true
            this.hasConnectionError = false
            this.isRejected = false
            if (typeof(this.isConnectedDelegate) === 'function') {
                this.isConnectedDelegate()
            }
        },

        disconnected() {
            this.isConnected = false
            this.hasConnectionError = true
            if (typeof(this.disconnectedDelegate) === 'function') {
                this.disconnectedDelegate()
            }
        },

        rejected() {
            console.log("User does not have edit priviledge.")
            this.isConnected = false
            this.isRejected = true
            if (typeof(this.rejectedDelegate) === 'function') {
                this.rejectedDelegate()
            }
        },

        received(data) {
            if (typeof(this.receivedDelegate) === 'function') {
                this.receivedDelegate(data.sections)
            }
            console.log('got data')
        },

        moveSection(from, to) {
            this.perform("move_section", {from: from, to: to})
        }
    })
}

export default createCourseSectionsChannel
