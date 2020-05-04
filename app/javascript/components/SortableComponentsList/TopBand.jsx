import React from 'react'

class TopBand extends React.Component {
    render() {
        const ErrorMessage = props => (
            props.hasConnectionError
                ? <span><strong>Error</strong> An error occured. Reload the page to reorder sections.</span>
            : <span>Waiting for connection to be established with the server...</span>
        )

        return(
            <div className={"alert alert-dismissible fade show " + (this.props.isConnected ? 'alert-info' : (this.props.hasConnectionError ? 'alert-danger' : 'alert-warning'))}>
                {this.props.isConnected
                    ? <span>Drag items to rearrange</span>
                    : <ErrorMessage />
                }
                <button type="button" className="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        )
    }
}

export default TopBand